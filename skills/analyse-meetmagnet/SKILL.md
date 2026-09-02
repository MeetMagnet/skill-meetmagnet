---
name: analyse-meetmagnet
description: Analyse complète d'un compte MeetMagnet (le tien, ou un compte auquel tu as accès). Croise les statistiques de prospection (MCP StatUser / Automatisation User MeetMagnet), la configuration du persona et les vraies conversations avec les prospects (MCP App MeetMagnet), puis produit un rapport Markdown qui dit où en est le compte, ce qui s'est passé, ce qui coince et ce qu'il faut faire. À utiliser dès qu'il faut faire le point sur un compte MeetMagnet : bilan de la semaine ou du mois, avant de changer le ciblage, après un changement de ciblage, quand les réponses baissent, ou en revue de routine. Se déclenche sur "analyse mon compte", "fais le point", "où on en est", "bilan MeetMagnet", "pourquoi j'ai peu de réponses", "analyse-meetmagnet".
---

# Analyse de compte MeetMagnet

## Prérequis

Deux connecteurs MCP MeetMagnet doivent être actifs dans la session :

- **Automatisation User MeetMagnet** (StatUser) : `https://stats.meetmagnet.fr/api/mcp/claude-agent`
- **App MeetMagnet** : `https://app.meet-magnet.com/mcp`

Si l'un des deux manque, dis-le tout de suite et renvoie vers `docs/configuration-compte-meetmagnet.md` du repo skill-meetmagnet. Une analyse à moitié sourcée n'a pas de valeur.

Ce skill ne suppose **aucun CRM ni aucun outil de compte rendu de réunion**. Si l'utilisateur a connecté son propre CRM ou agenda, tu peux les lire en complément, mais l'analyse doit tenir debout avec StatUser + App seulement.

## Arguments

`/analyse-meetmagnet {email} {jours} {consigne libre}`

| Argument | Obligatoire | Défaut | Exemple |
|---|---|---|---|
| email | non | compte connecté | `marie@exemple.fr` |
| jours | non | 30 | `60` |
| consigne | non | point de routine | `j'ai changé le ciblage il y a 15 jours` |

Sans email, travaille sur le persona par défaut du compte connecté (`list_accessible_personas` pour vérifier). Si plusieurs personas sont accessibles et que l'utilisateur n'a rien précisé, demande lequel. C'est la seule question autorisée avant de commencer.

## La consigne pilote l'angle

| Consigne du type | Ce que tu creuses en priorité |
|---|---|
| bilan de la semaine / du mois | volumes, taux de réponse, ouvertures commerciales, tendance |
| peu de réponses / ça ne marche pas | le ciblage (volume vs qualité), les intentions qui ramènent, les messages envoyés vs corrigés |
| on a changé la config | l'avant/après chiffré sur volume, réponses et conversions |
| qui relancer / quelles opportunités | les conversations ouvertes, les créneaux proposés sans réponse, les demandes prospects en attente |
| point de routine | analyse complète équilibrée |

## Phase 1 — Collecte

Appelle les outils un par un. Si un retour est trop long, extrais les chiffres exacts et les citations verbatim, jamais un résumé vague.

**A. Statistiques** — MCP `Automatisation User MeetMagnet`, dans cet ordre :
`resolve_persona` → `get_stats_positioning` → `get_stats_replies` → `get_stats_feedbacks` → `get_stats_messages` → `get_stats_intents` → `get_stats_opportunities` → `get_stats_agentos` → `get_stats_continuous_improvement` → `analyze_stats_period`

`get_stats_replies` déclenche la synchronisation et la classification des réponses : appelle-le avant de citer un chiffre de réponses.

**B. Configuration réelle** — MCP `App MeetMagnet` : `get_persona_config`.
Relève : localisations, métiers ciblés et exclus, secteurs, tailles, filtre concurrents, nombre exact d'intentions actives sur 15, recherches à 0 lead, intentions marquées ⚠️ PERFORMANTE, `messageTone`, présence de `sequenceInstructions` / `replyInstructions`. L'écart entre ce que le compte cible et ce que l'utilisateur veut vraiment est souvent la réponse.

**C. Le terrain** — MCP `App MeetMagnet` : `list_reply_leads` en filtre `opportunity` puis `need_reply`, puis `get_lead_conversation` sur les 4 à 6 conversations les plus avancées. Cherche précisément :
- les rendez-vous confirmés : date, heure, canal, preuve dans le fil
- les créneaux proposés en attente de réponse
- les demandes du prospect restées sans réponse
- les conversations où l'intérêt était clair mais où aucune date n'a été posée

Extrais les **verbatims**. Un chiffre convainc, un verbatim prouve.

**D. Ce que l'utilisateur sait et que les outils ne savent pas.** Si l'utilisateur a donné du contexte dans sa demande (objectifs, changement récent, contrainte), c'est une source à part entière. Ne le lui refais pas dire.

**E. La semaine AgentOS** (optionnel, si le compte l'utilise) — `list_agentos_proposals` pour voir ce qui a été proposé et décidé cette semaine. Utile pour la section « Ce qui s'est passé ».

**Croise systématiquement.** Une statistique sans conversation associée n'a pas de valeur commerciale. Une conversation sans statistique n'a pas de poids.

## Phase 2 — Le livrable

Lis `references/livrable.md` et suis la structure imposée. Markdown propre, une à deux pages écran.

Le livrable est écrit pour l'utilisateur du compte : direct, factuel, sans enrobage. Tu as le droit de dire que la configuration est mauvaise ou que MeetMagnet a proposé de mauvais prospects.

## Phase 3 — Les règles

- Aucun chiffre inventé, aucun arrondi flatteur. Chaque chiffre est traçable à un outil appelé.
- Si une source ne renvoie rien : « donnée non disponible sur la période ». Jamais d'estimation silencieuse.
- Quand deux sources divergent, donne les deux et explique l'écart.
- Zéro jargon : pas de « intent data », « scraping », « pipeline », « cohorte ». On parle de signaux, de conversations, d'opportunités, de rendez-vous.
- Phrases courtes. Bénéfice avant technique. Pas de tiret cadratin.
- **Aucune écriture sans validation explicite** : `create_intent`, `update_intent`, `deactivate_intent`, `create_search`, `update_search`, `deactivate_search`, `update_persona_config`, `send_reply`, `validate_lead_sequences`, `exclude_leads`, `apply_agentos_proposals`.
- Ne désactive jamais une intention ou une recherche marquée ⚠️ PERFORMANTE sans accord explicite. Préfère ajuster ou ajouter.

## Phase 4 — Ce que tu proposes ensuite

Hors livrable, quatre lignes maximum :
1. Le sujet à traiter en priorité cette semaine.
2. Les correctifs de configuration applicables immédiatement, sur validation.
3. Les conversations à relancer aujourd'hui.
4. Les livrables complémentaires possibles, sans les produire : nouvelles intentions (skill `signaux-achat` + `linkedin-recherche-intention`), réponses aux prospects (skill `conversation-b2b-rdv`), nouveau prompt de séquence (skill `prompt-sequence-meetmagnet`).

## Raccourcis de suivi

| Il dit | Tu fais |
|---|---|
| « applique les corrections de config » | Affiche l'avant/après, attends « oui », puis `update_persona_config` / `create_intent` / `create_search` |
| « propose de nouvelles intentions » | Skill `signaux-achat` puis `linkedin-recherche-intention`, puis `create_intent` + `create_search` après validation |
| « réponds aux prospects » | Skill `conversation-b2b-rdv`, `suggest_reply` puis `send_reply` après validation par conversation |
| « qu'est-ce qu'AgentOS a proposé ? » | `list_agentos_proposals`, cartes avant/après, puis `decide_agentos_proposal` et `apply_agentos_proposals` seulement sur « j'approuve, applique » |
| « passe-le en PDF » | Mets en page le livrable tel quel |
