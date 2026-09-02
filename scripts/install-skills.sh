#!/usr/bin/env bash
# Installe les 7 skills MeetMagnet là où ton assistant va les chercher.
#
# Usage :
#   ./scripts/install-skills.sh              # -> ~/.claude/skills (Claude Code, Cowork)
#   ./scripts/install-skills.sh <dossier>    # -> dossier de ton choix
#
# Depuis n'importe où, sans cloner :
#   curl -fsSL https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/scripts/install-skills.sh | bash

set -euo pipefail

REPO_URL="https://github.com/MeetMagnet/skill-meetmagnet.git"
DEST="${1:-$HOME/.claude/skills}"
SKILLS=(signaux-achat linkedin-recherche-intention redaction-message-prospection \
        conversation-b2b-rdv prompt-sequence-meetmagnet analyse-meetmagnet meetmagnet-execute)

# Trouve la source : le repo local si on est dedans, sinon un clone temporaire
SRC=""
here="$(cd "$(dirname "${BASH_SOURCE[0]:-.}")/.." 2>/dev/null && pwd || true)"
if [[ -n "$here" && -d "$here/skills/signaux-achat" ]]; then
  SRC="$here/skills"
else
  TMP="$(mktemp -d)"; trap 'rm -rf "$TMP"' EXIT
  echo "Téléchargement des skills..."
  git clone --depth 1 -q "$REPO_URL" "$TMP/repo"
  SRC="$TMP/repo/skills"
fi

mkdir -p "$DEST"
echo "Installation dans : $DEST"

installed=0
for s in "${SKILLS[@]}"; do
  [[ -d "$SRC/$s" ]] || { echo "  ! $s introuvable, ignoré"; continue; }
  rm -rf "${DEST:?}/$s"
  cp -R "$SRC/$s" "$DEST/$s"
  echo "  ✓ $s"
  installed=$((installed+1))
done

echo
echo "$installed skills installés dans $DEST"
echo
echo "Étape suivante : ajouter les 3 connecteurs MCP (c'est toi qui cliques)."
echo "  App MeetMagnet                 https://app.meet-magnet.com/mcp"
echo "  Automatisation User MeetMagnet https://stats.meetmagnet.fr/api/mcp/claude-agent"
echo "  Recherche prospects MeetMagnet https://mcp.meetmagnet.fr/mcp"
echo
echo "Détail : https://github.com/MeetMagnet/skill-meetmagnet/blob/main/INSTALL.md"
