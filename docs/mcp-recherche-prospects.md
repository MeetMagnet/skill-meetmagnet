# MCP Recherche prospects MeetMagnet

> Trouver des décideurs à contacter à partir de métiers et de signaux d'achat, et explorer les publications LinkedIn sur un sujet. Fonctionne sans compte MeetMagnet payant.

| | |
|---|---|
| **Site** | [mcp.meetmagnet.fr](https://mcp.meetmagnet.fr/) |
| **Lien MCP à coller** | `https://mcp.meetmagnet.fr/mcp` |
| **Connexion** | OAuth Google, depuis ton assistant IA |
| **Nom conseillé du connecteur** | `Recherche prospects MeetMagnet` |

## Comment se connecter

1. Dans ton assistant IA, ajoute un connecteur MCP distant avec l'URL `https://mcp.meetmagnet.fr/mcp`. Voir [INSTALL.md](../INSTALL.md).
2. Une fenêtre Google s'ouvre : connecte-toi avec ton compte Google.
3. Teste : « Trouve-moi 5 directeurs commerciaux de PME industrielles qui recrutent en ce moment ».

## Accès et quotas

| Rôle | Ce que tu as |
|---|---|
| Utilisateur (par défaut) | Recherche de prospects limitée à **50 prospects** au total + publications indexées |
| Partenaire | Même outils, **sans limite** |
| Admin MeetMagnet | Outils avancés sur `https://mcp.meetmagnet.fr/mcp/admin-search` (LinkedIn live, radar, lecture / édition persona) |

Pour passer en mode partenaire illimité : écris à contact@meet-magnet.com avec l'email Google utilisé.

## Ce que tu peux faire

### Chercher des personnes
`search_prospects` (côté admin : `admin_search_visible_prospects`). Trois entrées obligatoires :
- `include_jobs` : 2 à 5 intitulés de poste LinkedIn (ce que le prospect **est**), ex. `["Directeur commercial", "Head of Sales"]`
- `typed_search_signals` : 2 à 5 signaux `{label, type}` avec `type` INTEREST (sujet suivi) ou MOMENT (événement déclencheur), ex. `{"label": "recrutement d'un commercial", "type": "MOMENT"}`
- `exclude_jobs` : max 7 intitulés à rejeter (consultant, freelance, coach, indépendant, agence, cabinet, prestataire)

Optionnel : `count` (1 à 30, défaut 10).

Le skill `signaux-achat` construit les `typed_search_signals` correctement. Le skill `redaction-message-prospection` rédige ensuite le message d'accroche pour chaque prospect trouvé.

### Chercher des publications
`search_publications` (côté admin : `admin_search_publications`) : les posts LinkedIn indexés par MeetMagnet sur un sujet, avec URL, nombre de réactions, auteur. Utile pour voir de quoi parle un marché, sans liste de contacts. Paramètres : `topics` ou `typed_search_signals`, `min_reactions` (défaut 15), `search_window_days` (défaut 60), `count`.

### Outils admin (agences, partenaires avancés)
Sur `https://mcp.meetmagnet.fr/mcp/admin-search`, avec un compte élevé en admin :
- `linkedin_live_search_moment` / `linkedin_live_search_interet` : posts LinkedIn frais (30 jours) par mots-clés, contenu intégral. Le skill `linkedin-recherche-intention` écrit les requêtes.
- `admin_search_linkedin_persona_radar` : échantillonne ~10 profils d'un métier et remonte leurs posts et réactions. Un appel = un seul métier.
- `admin_search_trend_radar` : veille marché web + X sur des sujets, solutions, métiers.

## Repère simple

```
Je veux des PERSONNES à contacter      → search_prospects
Je veux des POSTS sur un sujet         → search_publications
Je veux des posts FRAIS (admin)        → linkedin_live_search_moment / _interet
Je veux ajouter un prospect trouvé     → add_manual_lead (MCP App MeetMagnet)
   dans mon compte MeetMagnet
```

## Enchaînement type : de la recherche au compte MeetMagnet

1. Skill `signaux-achat` : définir 3 à 5 signaux MOMENT + INTEREST pour la solution vendue.
2. `search_prospects` : 3 recherches en parallèle (signal fort, signal moyen, intérêt large).
3. Filtrer : fit persona + intensité du signal + originalité. Écarter les profils sans entreprise, hors zone, juniors, consultants.
4. Skill `redaction-message-prospection` : un message d'accroche par prospect retenu.
5. Si le compte App MeetMagnet est connecté : `add_manual_lead` avec l'URL LinkedIn et le contexte d'intention, pour que MeetMagnet génère et envoie la séquence.

Voir [exemples-demandes.md](exemples-demandes.md).
