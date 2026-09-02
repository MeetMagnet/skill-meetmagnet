# Exemples de demandes

> Des phrases réellement utilisées avec MeetMagnet depuis un assistant IA, avec ce qui se passe derrière. Copie-colle, adapte.

Les exemples sont classés par situation. Pour chacun : la demande, le skill qui s'active, les outils appelés, et le résultat attendu.

## Trouver des prospects

**« Trouve-moi 10 directeurs commerciaux de PME industrielles en France qui recrutent des commerciaux en ce moment, et écris-moi un message d'accroche pour chacun. »**
Skills : `signaux-achat` puis `redaction-message-prospection`.
Outils : `search_prospects` × 3 en parallèle (signal fort : recrutement commercial ; signal moyen : lancement d'une nouvelle offre ; intérêt : efficacité de la prospection B2B).
Résultat : une liste classée du signal le plus fort au plus faible, avec pour chaque prospect le métier simplifié, le signal décrit en langage humain (« structure son équipe commerciale dans un contexte de croissance »), l'URL du profil, et un message LinkedIn de 3 à 6 lignes.

**« Cherche des DAF d'ETI qui préparent la facturation électronique. »**
Skill : `signaux-achat` (domaine facturation électronique dans `references/exemples-par-domaine.md`).
Outils : `search_prospects` avec `include_jobs: ["DAF", "Directeur financier", "Responsable comptable"]`, signaux MOMENT « préparation à la réforme de la facturation électronique », « mise en place d'un outil de dématérialisation », INTEREST « conformité e-invoicing ».

**« De quoi parlent les directeurs RSE sur LinkedIn en ce moment ? »**
Aucun skill obligatoire.
Outils : `search_publications` avec `topics: ["stratégie RSE", "bilan carbone", "CSRD"]`.
Résultat : les posts les plus engageants avec URL, auteur, nombre de réactions. Utile pour caler des intentions ou du contenu.

**« Ajoute ces 3 prospects dans mon compte MeetMagnet avec le contexte qu'on a trouvé. »**
Outils : `add_manual_lead` × 3 (App), avec `linkedinUrl`, `intentContext` = le signal décrit, `postUrl` et `activityType` si un post a été identifié.
Résultat : les prospects arrivent dans « À valider » avec une séquence générée.

## Valider les prospects

**« Quels prospects sont à valider ? Vérifie qu'ils correspondent bien à ma cible, dis-moi ceux que je peux valider et ceux à exclure. »**
Outils : `list_pending_validation_leads`, puis `get_pending_validation_lead` sur chacun, puis `get_persona_config` pour comparer aux critères.
Résultat : un tableau « à valider / à exclure (motif) » avec un résumé des messages de séquence. Puis : « Vous voulez envoyer les séquences à ces X personnes ? ». Sur « oui » : `validate_lead_sequences` + `exclude_leads` avec `feedbackTypes`.

**« Le deuxième message de la séquence de Marie Dupont est trop long, raccourcis-le avant de valider. »**
Skill : `redaction-message-prospection` pour la réécriture.
Outils : `update_draft_sequence_message` puis `validate_lead_sequences` après accord.

## Répondre aux prospects

**« Qui m'a répondu ? Propose-moi une réponse pour chacun. »**
Skill : `conversation-b2b-rdv`.
Outils : `list_reply_leads` (need_reply), `get_lead_conversation`, `suggest_reply`.
Résultat : par conversation, l'historique résumé, la réponse proposée (courte, fractionnée en 2 ou 3 messages, une seule question). Envoi avec `send_reply` seulement après « ok envoie ».

**« Il me dit "pas le temps en ce moment, revenez en janvier". Qu'est-ce que je réponds ? »**
Skill : `conversation-b2b-rdv` (phase 7, blocage : offrir une ressource, pas relancer sur le RDV).
Résultat : une réponse qui accuse réception, propose une valeur gratuite, et pose la date de janvier sans pression.

**« Il est chaud, propose-lui un créneau et vérifie son email. »**
Skill : `conversation-b2b-rdv` (phases 5 et 6).
Résultat : proposition de 2 créneaux précis ou d'un lien de prise de RDV, puis validation explicite de l'email pro avant de considérer le RDV comme pris.

## Comprendre et améliorer le compte

**« Fais le point sur mon compte sur 30 jours. »**
Skill : `analyse-meetmagnet`.
Outils : StatUser (`get_stats_positioning`, `get_stats_replies`, `get_stats_feedbacks`, `get_stats_messages`, `get_stats_intents`, `get_stats_opportunities`, `analyze_stats_period`) + App (`get_persona_config`, `list_reply_leads`, `get_lead_conversation`).
Résultat : rapport avec verdict, chiffres, conversations qui comptent, ce qui coince, plan à 14 jours.

**« Pourquoi j'ai peu de réponses ? »**
Skill : `analyse-meetmagnet` avec l'angle « ça ne marche pas ».
Résultat : la cause racine (ciblage trop large, intentions qui tournent à vide, messages génériques) avec les chiffres qui la prouvent, et les correctifs à valider.

**« Quelles intentions me ramènent le plus de réponses ? Lesquelles couper ? »**
Outils : `get_stats_intents` (StatUser), `get_persona_config` (App).
Résultat : tableau intention → prospects → réponses → ouvertures. Les intentions ⚠️ PERFORMANTE ne sont jamais proposées à la désactivation sans accord.

**« Propose-moi 3 nouvelles intentions d'achat pour ma solution et les recherches LinkedIn qui vont avec. »**
Skills : `signaux-achat` puis `linkedin-recherche-intention`.
Outils : `get_intent_config_skill` (obligatoire avant), puis après validation `create_intent` + `create_search`.
Résultat : 3 intentions typées (au moins une MOMENT, une INTEREST) avec label, sujets, verbes, et 1 à 3 requêtes chacune, présentées avant écriture.

**« Ajoute "Directeur RSE" aux métiers ciblés et exclus les consultants. »**
Outils : `get_persona_config` puis `update_persona_config` avec `jobsInclude` et `jobsExclude`, après affichage de l'avant / après et accord.

## Configurer les messages

**« Réécris mes instructions de séquence : tutoiement, plus court, mets en avant le cas client Acme, LinkedIn J+0 / J+14 / J+30 sans email. »**
Skill : `prompt-sequence-meetmagnet`.
Outils : `get_message_config_skill`, `get_persona_config`.
Résultat : le prompt complet en 13 sections dans un bloc de code. Puis sur « pousse-le dans l'app » : `update_persona_config` avec `sequenceGenerationV2: true` et `sequenceInstructions`.

**« Fais aussi les instructions de conversation. »**
Skills : `prompt-sequence-meetmagnet` + `conversation-b2b-rdv`.
Résultat : un second prompt `replyInstructions` centré sur la gestion des réponses et la prise de RDV.

## La semaine avec AgentOS (StatUser)

**« Qu'est-ce qui a été proposé cette semaine ? »**
Outil : `list_agentos_proposals`.
Résultat : chaque proposition en avant / après (ciblage, intention, message), avec les décisions déjà prises.

**« J'accepte la 1 et la 3, on garde l'actuel pour la 2. »**
Outil : `decide_agentos_proposal` × 3. Rien n'est écrit en production à ce stade.

**« OK, j'approuve, applique. »**
Outil : `apply_agentos_proposals` avec `confirmApply: true`. Là seulement, ça part en production.

**« Lance le cycle de la semaine. »**
Outil : `launch_agentos_cycle`. Une seule fois par semaine ; si déjà lancé, l'assistant le dit.

**« Active les analyses auto le dimanche mais pas la mise en prod auto. »**
Outil : `set_agentos_auto_mode` avec `autoAnalysis: true`, `autoApply: false`.

## Exécuter les actions planifiées

**« meetmagnet-execute marie@exemple.fr 10 »**
Skill : `meetmagnet-execute`.
Outils : `resolve_persona`, `get_agent_config`, `list_due_actions`, puis pour chaque action `get_prospect_state`, `get_lead_conversation`, et `send_reply` / `validate_lead_sequences` / `exclude_leads`, puis `complete_action` / `cancel_action` / `fail_action`.
Résultat : un résumé par action (exécutée, annulée avec raison, échec technique, laissée à l'humain).

**« Montre-moi les prospects encore à traiter et prépare les relances. »**
Outils : `get_planning_lot`, puis `propose_actions` (non confirmées), relecture du bloc de revue, puis `confirm_actions` après accord.

## Pour les administrateurs et agences

Ces demandes nécessitent un compte administrateur MeetMagnet ; elles ne sont pas disponibles à un client standard.

**« Crée un compte démo pour paul@exemple.com et configure le persona à partir de son site web. »**
Outils : `create_demo_account` (renvoie un lien de définition du mot de passe, aucun email envoyé), puis `update_persona_config` (vendeur, `sellerSex`, offre, cible, `competitorFilter`, `advancedFilterDetails`, secteurs via `search_industries`), puis `signaux-achat` + `linkedin-recherche-intention` pour au moins 5 intentions (3 INTEREST + 3 MOMENT) avec leurs recherches.

**« Regénère le lien d'accès pour paul@exemple.com. »**
Outil : `get_demo_account_access_link`.

**« Quel est le ciblage actuel du compte client@exemple.com ? »**
Outil : `get_persona_config` avec `email`.
