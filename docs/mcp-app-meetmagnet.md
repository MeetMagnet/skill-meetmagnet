# MCP App MeetMagnet

> Le quotidien MeetMagnet depuis ton assistant IA : prospects, séquences, conversations, ciblage, intentions d'achat.

| | |
|---|---|
| **Lien MCP à coller** | `https://app.meet-magnet.com/mcp` |
| **Où l'activer côté MeetMagnet** | [app.meet-magnet.com/settings/integrations-ai](https://app.meet-magnet.com/settings/integrations-ai) (Paramètres → Intégrations IA) |
| **Connexion** | Ton compte MeetMagnet (OAuth). Tu vois ton compte, pas les autres. |
| **Nom conseillé du connecteur** | `App MeetMagnet` |

## Comment se connecter

1. Connecte-toi à MeetMagnet : [app.meet-magnet.com](https://app.meet-magnet.com).
2. Va dans **Paramètres → Intégrations IA** : [app.meet-magnet.com/settings/integrations-ai](https://app.meet-magnet.com/settings/integrations-ai). Cette page te confirme que le MCP est disponible pour ton compte et te donne le lien.
3. Dans ton assistant IA (Claude, ChatGPT, Mistral, Cursor…), ajoute un connecteur MCP distant avec l'URL `https://app.meet-magnet.com/mcp`. Voir [INSTALL.md](../INSTALL.md) pour le chemin exact selon l'assistant.
4. L'assistant ouvre une fenêtre de connexion MeetMagnet : autorise l'accès avec **ton propre compte**.
5. Teste : « Montre-moi la configuration de mon persona MeetMagnet ».

## Ce que ça donne accès

Ton compte, et seulement ton compte. Si personaId n'est pas précisé, l'assistant travaille sur le persona par défaut du compte connecté (même logique que l'app).

Un admin d'agence n'a pas de mode « je gère tous mes clients depuis une seule connexion ». Pour travailler sur un autre compte, il faut connecter ce compte-là au MCP, pas le compte agence.

## Ce que tu peux faire

### Regarder les prospects
- `search_leads` : chercher un prospect par nom, entreprise, email, URL LinkedIn. Renvoie le profil enrichi et son statut (à valider, non lu, opportunité, négatif, en séquence…).
- `list_pending_validation_leads` : les prospects avec une séquence en brouillon, à valider.
- `get_pending_validation_lead` : le détail d'un prospect à valider (séquence brouillon + critères de correspondance).
- `add_manual_lead` : ajouter un prospect à la main depuis son URL LinkedIn, avec le contexte d'intention.

### Valider ou écarter des séquences
- `validate_lead_sequences` : valider les séquences (brouillon → en attente d'envoi). **Toujours après confirmation explicite.**
- `exclude_leads` : écarter des prospects avec un motif (LOCATION, JOB, COMPETITOR, CUSTOMER, COMPANY_SIZE, INDUSTRY, CONTENT, OTHER, BLACKLIST). Le motif affine le ciblage.
- `update_draft_sequence_message` : corriger un message de séquence avant validation.

### Lire les conversations et répondre
- `list_reply_leads` : les prospects qui ont répondu (filtres : `need_reply` par défaut, `unread`, `opportunity`, `all`).
- `get_lead_conversation` : l'historique complet d'une conversation.
- `suggest_reply` : une réponse proposée par l'IA.
- `update_reply_draft` : ajuster le brouillon.
- `send_reply` : envoyer. **Toujours après confirmation explicite.**

### Modifier le ciblage et les messages
- `get_persona_config` : lire toute la configuration (cible, offre, messages, intentions, recherches). Les intentions performantes sont marquées ⚠️ PERFORMANTE.
- `update_persona_config` : modifier métiers, secteurs, tailles, localisations, vendeur, offre, ton (tutoiement / vouvoiement / selon profil), instructions de séquence et de conversation.
- `search_industries` : trouver les identifiants de secteurs avant de remplir les secteurs.
- `get_message_config_skill` : le guide de configuration des messages. **À lire avant de toucher aux messages.**

### Intentions d'achat et recherches
- `get_intent_config_skill` : le guide de configuration des intentions. **À lire avant de créer ou modifier une intention.**
- `create_intent` / `update_intent` / `deactivate_intent` : gérer les intentions (max 15 actives, type INTEREST ou MOMENT).
- `create_search` / `update_search` / `deactivate_search` : gérer les recherches LinkedIn d'une intention (max 3 actives par intention).

## Ce que tu ne peux pas faire

- Voir ou piloter les comptes d'autres utilisateurs.
- Créer un compte (outil réservé aux administrateurs MeetMagnet).
- Envoyer un message, valider une séquence ou modifier la configuration sans que tu aies dit oui.

## Règles que l'assistant doit respecter

1. Toute écriture (envoi, validation, exclusion, changement de config, intention) demande une confirmation explicite. L'assistant affiche ce qu'il va faire, tu dis « oui ».
2. Une intention ou une recherche marquée ⚠️ PERFORMANTE ne se désactive pas sans ton accord explicite.
3. Avant de créer une intention : `get_intent_config_skill` + skill `signaux-achat` + skill `linkedin-recherche-intention`.
4. Avant de toucher aux messages : `get_message_config_skill` + skill `prompt-sequence-meetmagnet`.
5. Pour répondre à un prospect : skill `conversation-b2b-rdv`.

## Workflows types

**Valider les prospects du jour**
1. `list_pending_validation_leads`
2. `get_pending_validation_lead` sur chacun
3. L'assistant présente qui correspond, qui exclure, avec un résumé des messages
4. Tu confirmes → `validate_lead_sequences` / `exclude_leads`

**Traiter les réponses**
1. `list_reply_leads` (need_reply)
2. `get_lead_conversation`
3. `suggest_reply` puis skill `conversation-b2b-rdv` pour ajuster
4. Tu confirmes → `send_reply`

**Améliorer le ciblage**
1. `get_persona_config`
2. Skill `signaux-achat` pour proposer de nouvelles intentions
3. Skill `linkedin-recherche-intention` pour les requêtes
4. Tu confirmes → `create_intent` + `create_search`

Voir [exemples-demandes.md](exemples-demandes.md) pour des phrases prêtes à l'emploi.
