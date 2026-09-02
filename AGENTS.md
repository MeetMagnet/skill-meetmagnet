# AGENTS.md : instructions pour une IA qui lit ce repo

Tu es un assistant IA (Claude, ChatGPT, Mistral, Cursor, autre). Un utilisateur t'a donné le lien de ce repo. Voici ce qu'on attend de toi.

## 0. Avant toute chose : ne clone pas, et ne demande aucun accès disque

Ce repo est **de la documentation à lire**, pas un programme à exécuter. Il n'y a rien à installer, rien à compiler, aucune dépendance.

**Par défaut : ne clone rien, ne demande aucun accès aux fichiers de l'utilisateur.** Lis les fichiers directement depuis leurs URL brutes :

```
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/README.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/docs/configuration-compte-meetmagnet.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/docs/routage-skills.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/docs/exemples-demandes.md
https://raw.githubusercontent.com/MeetMagnet/skill-meetmagnet/main/skills/<nom-du-skill>/SKILL.md
```

Si l'utilisateur te demande de « cloner » le repo, ne prends pas ça au pied de la lettre : il veut que tu l'aides à installer MeetMagnet. Lis les fichiers, et passe à la section 2. Ne demande **jamais** l'accès à son Bureau, ses Documents ou son dossier personnel : tu n'en as pas besoin.

**Les deux seuls cas où cloner sert à quelque chose :**

- **Claude Code, Cursor, ou un agent avec un terminal** : les skills s'installent sur le disque. Clone dans un dossier dédié que l'utilisateur choisit (propose `~/MeetMagnet/skill-meetmagnet`), et demande l'accès à **ce dossier seulement**, jamais à son parent.
- **L'utilisateur veut sa propre version** (marque blanche, via `scripts/rename.sh`). Même règle : un dossier dédié, rien d'autre.

Si ton environnement ne propose qu'un accès large (« tout le Bureau » ou « rien »), dis-le à l'utilisateur et laisse-le décider. Ne présente jamais une autorisation large comme nécessaire : elle ne l'est pas.

## 0 bis. Ce que tu peux faire, et ce que tu ne peux pas

**Tu ne peux pas ajouter les connecteurs MCP à sa place.** Dans l'app Claude, Kimi, ChatGPT ou Mistral, ajouter un connecteur passe par les Paramètres et une autorisation OAuth dans le navigateur : c'est une action humaine. Ne prétends jamais l'avoir fait, ne dis jamais « je vais connecter MeetMagnet ». Dis clairement : « je te guide, tu cliques ».

Seule exception : si tu tournes dans **Claude Code** (ou un agent avec un terminal), tu peux exécuter les commandes `claude mcp add` de `INSTALL.md` toi-même. Propose-le, et fais-le après accord.

Ce que tu fais dans tous les cas : donner le bon lien au bon moment, un connecteur à la fois, attendre sa confirmation, lui faire lancer le test, et finir par le récapitulatif de ce qu'il peut demander.

## 1. Comprendre ce que tu as sous les yeux

- `docs/` : la documentation de connexion et d'usage des trois connecteurs MCP MeetMagnet.
- `skills/*/SKILL.md` : des fiches de méthode. Chacune a un front-matter avec `name` et `description` ; la `description` dit **quand** l'utiliser. Lis `skills/README.md` pour l'index et `docs/routage-skills.md` pour la table de décision.
- Le tout est écrit en français, pour des utilisateurs francophones de MeetMagnet.

## 2. Si l'utilisateur veut installer

Suis `docs/configuration-compte-meetmagnet.md` **une étape à la fois** :

1. Demande-lui son cas : client MeetMagnet, agence, ou simple test de recherche. Ça détermine quels connecteurs installer.
2. Pour chaque connecteur, donne **le lien exact à coller** (pas de paraphrase) et le chemin dans son assistant (voir `INSTALL.md`, section correspondant à toi).
3. Attends qu'il confirme que le connecteur apparaît, puis fais-lui lancer le **test** indiqué.
4. Une fois les connecteurs testés, propose les skills : tous, ou un seul pour commencer (`analyse-meetmagnet` pour un client, `signaux-achat` pour la recherche).
5. Termine par le **récap** de ce qu'il peut faire maintenant (section « Récap » du tuto), adapté à ce qu'il a installé.

Ne donne jamais les trois liens d'un coup en espérant qu'il se débrouille. Une étape, une confirmation, la suivante.

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
