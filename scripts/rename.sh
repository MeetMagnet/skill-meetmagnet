#!/usr/bin/env bash
# Renomme la marque MeetMagnet dans tout le repo (fichiers, dossiers, skills).
#
# Usage :
#   ./scripts/rename.sh NouveauNom [--app-url URL] [--stats-url URL] [--search-url URL] [--contact EMAIL] [--dry-run]
#
# Exemple :
#   ./scripts/rename.sh NeoResilia
#   ./scripts/rename.sh NeoResilia --app-url https://app.neoresilia.fr/mcp --contact contact@neoresilia.fr
#
# Ce que ça fait :
#   MeetMagnet   -> NouveauNom
#   meetmagnet   -> nouveaunom       (identifiants, noms de skills, chemins)
#   meet-magnet  -> nouveaunom       (hors URL si les URL ne sont pas remplacées)
#   MEETMAGNET   -> NOUVEAUNOM
#   analyse-meetmagnet -> analyse-nouveaunom, etc. (dossiers renommés)
# Les URL de connexion sont conservées par défaut (même plateforme derrière).
# Passe --app-url / --stats-url / --search-url pour les remplacer aussi.

set -euo pipefail

if [[ $# -lt 1 ]]; then
  sed -n '2,20p' "$0"; exit 1
fi

NEW="$1"; shift
NEW_LOWER="$(echo "$NEW" | tr '[:upper:]' '[:lower:]' | tr -cd 'a-z0-9')"
NEW_UPPER="$(echo "$NEW_LOWER" | tr '[:lower:]' '[:upper:]')"

APP_URL="https://app.meet-magnet.com/mcp"
STATS_URL="https://stats.meetmagnet.fr/api/mcp/claude-agent"
SEARCH_URL="https://mcp.meetmagnet.fr/mcp"
CONTACT="contact@meet-magnet.com"
NEW_APP_URL=""; NEW_STATS_URL=""; NEW_SEARCH_URL=""; NEW_CONTACT=""
DRY=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app-url) NEW_APP_URL="$2"; shift 2;;
    --stats-url) NEW_STATS_URL="$2"; shift 2;;
    --search-url) NEW_SEARCH_URL="$2"; shift 2;;
    --contact) NEW_CONTACT="$2"; shift 2;;
    --dry-run) DRY=1; shift;;
    *) echo "Option inconnue : $1"; exit 1;;
  esac
done

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Fichiers texte à traiter (hors .git et ce script)
mapfile -t FILES < <(grep -rIl --exclude-dir=.git --exclude="rename.sh" -e 'MeetMagnet' -e 'meetmagnet' -e 'meet-magnet' -e 'MEETMAGNET' . || true)

echo "Marque : MeetMagnet -> $NEW  (id: $NEW_LOWER)"
echo "Fichiers concernés : ${#FILES[@]}"

# Protège les URL et l'email qu'on ne remplace pas, via des marqueurs temporaires
PROTECT=()
[[ -z "$NEW_APP_URL" ]] && PROTECT+=("$APP_URL")
[[ -z "$NEW_STATS_URL" ]] && PROTECT+=("$STATS_URL")
[[ -z "$NEW_SEARCH_URL" ]] && PROTECT+=("$SEARCH_URL")
[[ -z "$NEW_CONTACT" ]] && PROTECT+=("$CONTACT")
# Domaines web associés (pages de settings, dashboard, site) : même logique
[[ -z "$NEW_APP_URL" ]] && PROTECT+=("app.meet-magnet.com")
[[ -z "$NEW_STATS_URL" ]] && PROTECT+=("stats.meetmagnet.fr")
[[ -z "$NEW_SEARCH_URL" ]] && PROTECT+=("mcp.meetmagnet.fr")

for f in "${FILES[@]}"; do
  [[ $DRY -eq 1 ]] && { echo "  $f"; continue; }
  tmp="$f.tmp.$$"
  cp "$f" "$tmp"
  i=0
  for p in "${PROTECT[@]}"; do
    sed -i "s|$p|__KEEP_${i}__|g" "$tmp"; i=$((i+1))
  done
  # Remplacement des URL demandées
  [[ -n "$NEW_APP_URL" ]] && sed -i "s|$APP_URL|$NEW_APP_URL|g; s|app.meet-magnet.com|$(echo "$NEW_APP_URL" | sed -E 's#https?://([^/]+).*#\1#')|g" "$tmp"
  [[ -n "$NEW_STATS_URL" ]] && sed -i "s|$STATS_URL|$NEW_STATS_URL|g; s|stats.meetmagnet.fr|$(echo "$NEW_STATS_URL" | sed -E 's#https?://([^/]+).*#\1#')|g" "$tmp"
  [[ -n "$NEW_SEARCH_URL" ]] && sed -i "s|$SEARCH_URL|$NEW_SEARCH_URL|g; s|mcp.meetmagnet.fr|$(echo "$NEW_SEARCH_URL" | sed -E 's#https?://([^/]+).*#\1#')|g" "$tmp"
  [[ -n "$NEW_CONTACT" ]] && sed -i "s|$CONTACT|$NEW_CONTACT|g" "$tmp"
  # Marque
  sed -i "s|MeetMagnet|$NEW|g; s|MEETMAGNET|$NEW_UPPER|g; s|meet-magnet|$NEW_LOWER|g; s|meetmagnet|$NEW_LOWER|g" "$tmp"
  # Restaure ce qui était protégé
  i=0
  for p in "${PROTECT[@]}"; do
    sed -i "s|__KEEP_${i}__|$p|g" "$tmp"; i=$((i+1))
  done
  mv "$tmp" "$f"
done

# Renomme les dossiers et fichiers contenant "meetmagnet"
while IFS= read -r path; do
  new="$(dirname "$path")/$(basename "$path" | sed "s|meetmagnet|$NEW_LOWER|g")"
  if [[ $DRY -eq 1 ]]; then echo "  $path -> $new"; else mv "$path" "$new"; fi
done < <(find . -depth -not -path './.git/*' -name '*meetmagnet*' | sort -r)

[[ $DRY -eq 1 ]] && { echo "(dry-run : rien modifié)"; exit 0; }

echo "Terminé. Vérifie avec : git diff --stat"
echo "Pense à mettre à jour le lien du repo dans README.md et INSTALL.md si tu publies sous un autre dépôt."
