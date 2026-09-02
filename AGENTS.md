# AGENTS.md : instructions pour une IA qui lit ce repo

Tu es un assistant IA (Claude, ChatGPT, Mistral, Cursor, autre). Un utilisateur t'a donné le lien de ce repo. Voici ce qu'on attend de toi.

## MODE INSTALLATION — si l'utilisateur dit « installe ça »

C'est le cas le plus fréquent. Fais exactement ces 4 étapes, dans l'ordre, sans en sauter.

### Étape A — Installer les skills

**Si tu as un terminal** (Claude Code, Cowork, Cursor, agent avec accès shell) : lance cette commande, c'est tout.

```bash
curl -fsSL https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/scripts/install-skills.sh | bash
```

Elle installe les 7 skills dans `~/.claude/skills/`. Pour un autre emplacement, ajoute-le en argument (`| bash -s ~/.cursor/rules` par exemple). Annonce le résultat : « 7 skills installés ». Ne demande **aucun** accès au Bureau, aux Documents ou au dossier personnel : la commande n'écrit que dans le dossier de skills.

**Si tu n'as pas de terminal** (Claude web/mobile, ChatGPT, Le Chat, Kimi en mode chat) : tu ne peux pas installer de fichiers. Dis-le franchement, puis propose l'équivalent : « je charge les skills dans notre conversation ». Lis les 7 `SKILL.md` depuis leurs URL brutes et garde-les en contexte :

```
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/signaux-achat/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/linkedin-recherche-intention/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/redaction-message-prospection/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/conversation-b2b-rdv/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/prompt-sequence-meetmagnet/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/analyse-meetmagnet/SKILL.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/meetmagnet-execute/SKILL.md
```

Pour que ce soit permanent, dis-lui comment : ChatGPT → créer un Projet et y joindre ces fichiers ; Le Chat / Kimi → coller les `SKILL.md` dans les instructions d'un agent ; Claude web → Paramètres → Skills.

Ne clone jamais le repo « pour voir ». Il n'y a rien à exécuter d'autre que le script ci-dessus.

### Étape B — Faire ajouter les 3 connecteurs MCP

**Tu ne peux pas les ajouter toi-même.** Dans une app, ajouter un connecteur passe par Paramètres → Connecteurs et une autorisation OAuth dans le navigateur : c'est une action humaine. Ne dis jamais « je connecte MeetMagnet ». Dis : « je te donne le lien, tu le colles, tu autorises, tu me dis quand c'est fait ».

Seule exception : en **Claude Code**, tu peux exécuter les `claude mcp add` toi-même. Propose-le, fais-le après accord, puis dis-lui de lancer `/mcp` pour s'authentifier.

Donne-les **un par un**, en attendant sa confirmation entre chaque. Le nom est important : les skills désignent les connecteurs par ces noms exacts.

| Ordre | Nom à donner au connecteur | URL à coller |
|---|---|---|
| 1 | `App MeetMagnet` | `https://app.meet-magnet.com/mcp` |
| 2 | `Automatisation User MeetMagnet` | `https://stats.meetmagnet.fr/api/mcp/claude-agent` |
| 3 | `Recherche prospects MeetMagnet` | `https://mcp.meetmagnet.fr/mcp` |

En Claude Code ou dans un `mcp.json`, les espaces ne passent pas : utilise `App_MeetMagnet`, `Automatisation_User_MeetMagnet`, `Recherche_prospects_MeetMagnet`.

Le chemin exact dans chaque app est dans `INSTALL.md`. Précise aussi avec quel compte il s'authentifie : son compte MeetMagnet pour le 1, son compte StatUser pour le 2, son compte Google pour le 3.

Les 2 et 3 sont optionnels : le 2 si l'utilisateur est client MeetMagnet et veut ses statistiques, le 3 s'il veut chercher de nouveaux prospects. Demande-lui son cas avant, ne fais pas installer les trois par réflexe.

### Étape C — Vérifier

Après chaque connecteur ajouté, fais-lui lancer le test correspondant et vérifie que tu vois bien les outils :

| Connecteur | Demande de test | Ce que tu dois obtenir |
|---|---|---|
| App MeetMagnet | « Montre-moi la configuration de mon persona » | Sa cible, son offre, ses intentions |
| Automatisation User MeetMagnet | « Bilan de mes réponses sur 30 jours » | Des réponses classées par motif |
| Recherche prospects MeetMagnet | « Trouve-moi 5 DRH de PME qui déploient un SIRH » | 5 profils avec un signal chacun |

Si un test échoue, va voir « Problèmes fréquents » dans `docs/configuration-compte-meetmagnet.md`. Ne passe pas à la suite tant qu'un connecteur annoncé comme ajouté ne répond pas.

### Étape D — Récapituler

Termine **toujours** par ce récapitulatif, adapté à ce qui est réellement installé. Sans ça, l'utilisateur a des outils et ne sait pas quoi en faire.

> Tu peux maintenant me demander, par exemple :
> - « Quels prospects sont à valider ? Dis-moi lesquels correspondent et lesquels exclure. »
> - « Qui m'a répondu ? Propose-moi une réponse pour chacun. »
> - « Fais le point sur mon compte sur 30 jours. »
> - « Pourquoi j'ai peu de réponses ? »
> - « Propose-moi 3 nouvelles intentions d'achat et les recherches LinkedIn qui vont avec. »
> - « Réécris mes instructions de séquence en tutoiement, plus court. »
> - « Trouve-moi 10 DAF d'ETI qui préparent la facturation électronique, avec un message pour chacun. »
>
> Et la règle de base : je ne valide, n'envoie et ne modifie jamais rien sans que tu me dises oui.

## 1. Comprendre ce que tu as sous les yeux

- `docs/` : la documentation de connexion et d'usage des trois connecteurs MCP MeetMagnet.
- `skills/*/SKILL.md` : des fiches de méthode. Chacune a un front-matter avec `name` et `description` ; la `description` dit **quand** l'utiliser. Lis `skills/README.md` pour l'index et `docs/routage-skills.md` pour la table de décision.
- Le tout est écrit en français, pour des utilisateurs francophones de MeetMagnet.

## 2. Si l'utilisateur veut installer

Applique le **MODE INSTALLATION** ci-dessus. Le détail écrit, si tu as besoin de citer une page : `docs/configuration-compte-meetmagnet.md` pour le parcours complet, `INSTALL.md` pour le chemin exact dans chaque app, et `docs/mcp-app-meetmagnet.md`, `docs/mcp-statuser.md`, `docs/mcp-recherche-prospects.md` pour le détail d'un connecteur.

## 3. Si l'utilisateur veut travailler

Utilise la table de `docs/routage-skills.md` pour choisir le skill, lis son `SKILL.md`, applique-le. Les enchaînements courants :

- Trouver des prospects : `signaux-achat` → recherche → `redaction-message-prospection`
- Améliorer le ciblage : `signaux-achat` → `linkedin-recherche-intention` → `create_intent` + `create_search`
- Répondre à un prospect : `conversation-b2b-rdv`
- Configurer les messages : `prompt-sequence-meetmagnet`
- Faire le point : `analyse-meetmagnet`
- Exécuter les actions planifiées : `meetmagnet-execute`

## 4. Les règles non négociables

- **Aucune écriture sans validation explicite** : envoi de message, validation de séquence, exclusion, modification de configuration, création ou désactivation d'intention, application de propositions AgentOS. Tu montres ce que tu vas faire, l'utilisateur dit « oui », tu appliques. Pour AgentOS, la phrase attendue est claire : « j'approuve, applique ».
- **Un connecteur = un compte.** Ne prétends pas pouvoir piloter d'autres comptes.
- **Ne désactive jamais** une intention ou une recherche marquée ⚠️ PERFORMANTE sans accord explicite.
- **Avant de créer une intention**, appelle `get_intent_config_skill` (App). **Avant de toucher aux messages**, appelle `get_message_config_skill`.
- **Dans un message adressé à un prospect**, jamais : « tu as liké », « j'ai vu ton post », auto-présentation en première phrase, compliment sur un post seulement liké, plus d'une question, mention de MeetMagnet ou d'une IA.
- **Aucun chiffre inventé.** Si un outil ne renvoie rien, dis-le.

## 5. Si un connecteur manque

Dis-le en une phrase, donne le lien à coller et la page de doc correspondante, et continue avec ce que tu peux faire sans. Exemples :
- Pas de StatUser : `analyse-meetmagnet` ne peut pas donner les chiffres, mais peut lire la configuration et les conversations via l'App.
- Pas d'App : tu peux chercher des prospects et rédiger des messages, pas les envoyer.
- Pas de Recherche prospects : tu peux quand même définir des signaux et des intentions pour le compte.

## 6. Vocabulaire

- **Persona** : la configuration d'un compte MeetMagnet (qui vend quoi à qui, avec quels messages). Un compte a un persona par défaut.
- **Intention d'achat** : un signal détecté sur LinkedIn, typé MOMENT (événement publié) ou INTEREST (sujet suivi). Max 15 actives.
- **Recherche** : une requête LinkedIn rattachée à une intention. Max 3 actives par intention.
- **Séquence** : les messages générés pour un prospect. Brouillon → à valider → en attente → envoyé.
- **AgentOS** : le cycle hebdomadaire d'amélioration continue (StatUser) qui propose des changements de configuration en avant / après.
- **Action** : une unité de pilotage prospect par prospect (WRITE_MESSAGE, FOLLOW_UP, VALIDATE_PROSPECT, WAIT, ARCHIVE, ASK_HUMAN) proposée par un Planner et exécutée par un Executor.
