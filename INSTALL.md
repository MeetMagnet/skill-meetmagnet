# INSTALL : ajouter les connecteurs MeetMagnet dans ton assistant IA

Les trois connecteurs MeetMagnet sont des **serveurs MCP distants** (Model Context Protocol). Tous les assistants qui supportent le MCP les acceptent de la même façon : tu colles une URL, tu autorises avec ton compte, c'est fini.

Les URL :

```
App MeetMagnet        https://app.meet-magnet.com/mcp
StatUser              https://stats.meetmagnet.fr/api/mcp/claude-agent
Recherche prospects   https://mcp.meetmagnet.fr/mcp
```

Les menus des assistants changent souvent. Les chemins ci-dessous sont ceux de septembre 2026 ; si tu ne les retrouves pas, cherche « MCP », « Connecteurs » ou « Intégrations » dans les paramètres.

## Claude (app web, desktop, mobile)

1. Paramètres → **Connecteurs** → **Ajouter un connecteur personnalisé**.
2. Nom : `App MeetMagnet`. URL : `https://app.meet-magnet.com/mcp`. Ajouter.
3. Clique **Connecter** : la page de connexion MeetMagnet s'ouvre, autorise.
4. Recommence pour StatUser et Recherche prospects.
5. Dans une conversation, vérifie que les connecteurs sont activés (icône outils / connecteurs sous la zone de saisie).

**Skills** : Paramètres → **Skills** (ou Capacités) → importer chaque dossier de `skills/`. Ou plus simple : colle le lien du repo dans une conversation et dis « installe les skills de ce repo ».

## Claude Code (terminal)

```bash
claude mcp add --transport http app-meetmagnet https://app.meet-magnet.com/mcp
claude mcp add --transport http statuser-meetmagnet https://stats.meetmagnet.fr/api/mcp/claude-agent
claude mcp add --transport http recherche-meetmagnet https://mcp.meetmagnet.fr/mcp
```

Puis dans Claude Code : `/mcp` pour lancer l'authentification de chacun.

**Skills** : copie les dossiers de `skills/` dans `~/.claude/skills/` (global) ou `.claude/skills/` (projet).

```bash
git clone https://github.com/MeetMagnet/skill-meetmagnet.git
cp -r skill-meetmagnet/skills/* ~/.claude/skills/
```

## ChatGPT

1. Paramètres → **Connecteurs** (ou **Apps et connecteurs**) → **Créer** / **Ajouter un connecteur MCP** (nécessite parfois le mode développeur, dans Paramètres → Connecteurs → Avancé).
2. Nom : `App MeetMagnet`. URL du serveur MCP : `https://app.meet-magnet.com/mcp`. Authentification : OAuth. Créer.
3. Connecte-toi quand la fenêtre MeetMagnet s'ouvre.
4. Recommence pour les deux autres.
5. Dans une conversation, active le connecteur via le bouton **+** / outils.

**Skills** : crée un **Projet** « MeetMagnet », colle `skills/README.md` et `docs/routage-skills.md` dans les instructions, et joins les `SKILL.md` en fichiers. Ou crée un GPT dédié avec ces fichiers en connaissance.

## Mistral (Le Chat)

1. Paramètres → **Connecteurs** / **Intégrations** → **Ajouter un connecteur MCP personnalisé**.
2. Colle l'URL, nomme-le, autorise.
3. Recommence pour chaque connecteur.

**Skills** : ajoute les `SKILL.md` en instructions d'un agent ou d'un projet, avec `skills/README.md` en premier.

## Cursor / VS Code / Windsurf et autres éditeurs

Fichier `mcp.json` (Cursor : `~/.cursor/mcp.json` ou `.cursor/mcp.json` dans le projet) :

```json
{
  "mcpServers": {
    "app-meetmagnet": { "url": "https://app.meet-magnet.com/mcp" },
    "statuser-meetmagnet": { "url": "https://stats.meetmagnet.fr/api/mcp/claude-agent" },
    "recherche-meetmagnet": { "url": "https://mcp.meetmagnet.fr/mcp" }
  }
}
```

L'éditeur lance l'authentification OAuth au premier appel.

**Skills** : ajoute les `SKILL.md` comme règles (Cursor : `.cursor/rules/`) ou colle-les dans les instructions du projet.

## Autres clients MCP

Tout client qui accepte un serveur MCP distant en HTTP (streamable HTTP ou SSE) avec OAuth fonctionne. Si ton client demande un type de transport : **HTTP**.

## Faut-il cloner le repo ?

**Dans une app (Claude, ChatGPT, Kimi, Mistral) : non.** Il n'y a rien à exécuter. L'assistant lit la doc en ligne et te guide ; toi tu colles les URL dans les Paramètres. Si un assistant réclame l'accès à ton Bureau ou tes Documents pour « cloner le repo », refuse : il n'en a pas besoin.

**Dans Claude Code ou Cursor : oui**, parce que les skills s'installent sur ton disque. Clone dans un dossier dédié et n'autorise l'accès qu'à celui-là :

```bash
mkdir -p ~/MeetMagnet && cd ~/MeetMagnet
git clone https://github.com/MeetMagnet/skill-meetmagnet.git
```

## Vérifier que ça marche

| Connecteur | Demande de test | Ce que tu dois voir |
|---|---|---|
| App MeetMagnet | « Montre-moi la configuration de mon persona MeetMagnet » | Ta cible, ton offre, tes intentions |
| StatUser | « Fais-moi le bilan de mes réponses sur 30 jours » | Des réponses classées par motif |
| Recherche prospects | « Trouve-moi 5 DRH de PME qui déploient un SIRH » | 5 profils avec un signal chacun |

Puis, si les skills sont installés : « Fais le point sur mon compte MeetMagnet sur 30 jours » doit produire un rapport structuré et te demander confirmation avant toute modification.

## Problèmes fréquents

Voir la section dédiée dans [docs/configuration-compte-meetmagnet.md](docs/configuration-compte-meetmagnet.md#problèmes-fréquents).
