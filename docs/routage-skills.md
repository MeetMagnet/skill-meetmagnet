# Routage des skills : quel skill, quand, pourquoi

> Pour l'IA : c'est ta table de décision. Pour l'humain : c'est la carte de ce que l'assistant sait faire.

## La table de décision

| L'utilisateur dit… | Skill à appeler | Connecteur(s) | Pourquoi ce skill |
|---|---|---|---|
| « Trouve-moi des prospects », « qui contacter », « cherche des directeurs X qui … » | `signaux-achat` → puis `redaction-message-prospection` | Recherche prospects | Il faut d'abord de bons signaux (`typed_search_signals`), puis un message par prospect |
| « Quels signaux d'achat pour ma solution », « quelles intentions », « améliore mes intentions » | `signaux-achat` → `linkedin-recherche-intention` | App | `signaux-achat` définit le quoi (MOMENT / INTEREST), `linkedin-recherche-intention` écrit les requêtes LinkedIn |
| « Écris les requêtes LinkedIn », « recherche booléenne », « mots-clés pour détecter … » | `linkedin-recherche-intention` | App (create_search) ou admin live | Produit 10 requêtes classées, booléennes seulement quand nécessaire |
| « Écris un message à ce prospect », « message d'accroche », « relance », « à partir de ce post » | `redaction-message-prospection` | aucun obligatoire | Méthode signal → accroche → message, sans « j'ai vu que tu as liké » |
| « Réponds à ce prospect », « il m'a répondu ça », « comment décrocher le RDV », « il hésite » | `conversation-b2b-rdv` | App (get_lead_conversation, send_reply) | Setter conversationnel : découverte, qualification, proposition de créneau, validation de l'email |
| « Configure mes messages », « prompt de séquence », « instructions de séquence », « change le ton » | `prompt-sequence-meetmagnet` | App (get_message_config_skill, update_persona_config) | Produit le prompt à coller dans le champ instructions de séquence |
| « Fais le point », « bilan », « où on en est », « pourquoi peu de réponses », « analyse mon compte » | `analyse-meetmagnet` | StatUser + App | Croise stats, config et conversations réelles, rapport structuré |
| « Exécute les actions planifiées », « traite les actions dues de … », « meetmagnet-execute » | `meetmagnet-execute` | StatUser + App | Vérifie la pertinence de chaque action confirmée avant de l'exécuter |
| « Qu'est-ce qu'AgentOS a proposé », « applique les propositions » | aucun skill, outils StatUser directs | StatUser | list → decide → apply avec `confirmApply: true` |
| « Valide les prospects », « qui exclure » | aucun skill, workflow App | App | list_pending → détail → présentation → validate / exclude après confirmation |

## Les enchaînements

Les skills se passent le relais. Voici les chaînes complètes.

### Chaîne 1 : trouver et contacter (sans compte MeetMagnet)
```
signaux-achat  →  search_prospects  →  filtrage qualité  →  redaction-message-prospection
```
Un signal bien défini donne de bons prospects. Un message basé sur le signal donne des réponses. Si le compte App est connecté, terminer par `add_manual_lead`.

### Chaîne 2 : configurer ou améliorer un compte MeetMagnet
```
get_persona_config  →  signaux-achat  →  linkedin-recherche-intention  →  create_intent + create_search
                    →  prompt-sequence-meetmagnet  →  update_persona_config (sequenceInstructions)
```
Le ciblage (qui) puis les intentions (quand) puis les messages (comment). Chaque écriture après confirmation.

### Chaîne 3 : le quotidien
```
list_pending_validation_leads  →  validate / exclude
list_reply_leads  →  get_lead_conversation  →  conversation-b2b-rdv  →  send_reply
```

### Chaîne 4 : la semaine
```
analyse-meetmagnet  →  list_agentos_proposals  →  decide  →  apply (« j'approuve, applique »)
```
L'analyse dit ce qui coince, AgentOS propose les corrections, l'utilisateur tranche.

### Chaîne 5 : l'exécution automatisée
```
Planner (get_planning_lot → propose_actions → confirm_actions)  →  meetmagnet-execute
```
Le Planner propose et confirme, l'Executor vérifie et exécute. Jamais l'inverse.

## Ce que les skills ont en commun

- Ils parlent tous la même langue des signaux : **MOMENT** (un événement publié qui précède l'achat) et **INTEREST** (un sujet suivi). Définie dans `signaux-achat`, reprise partout.
- Ils s'appuient sur la même grille d'analyse du comportement d'achat (EKB, TRA, TPB, Howard-Sheth) pour distinguer un vrai signal d'un bruit.
- Ils ont les mêmes interdits d'écriture : jamais « tu as liké », jamais d'auto-présentation en première phrase, jamais de compliment sur un post seulement liké, une seule question par message.
- Ils ne mentionnent jamais MeetMagnet ni une IA dans un message adressé à un prospect.
- **Aucune écriture sans validation explicite de l'utilisateur.**

## Ce que les skills ne couvrent pas (volontairement)

Cette version est faite pour **l'utilisateur d'un compte MeetMagnet**. Elle ne suppose ni CRM, ni outil de compte rendu de réunion, ni boîte mail connectée. Si l'utilisateur a ses propres connecteurs (CRM, agenda), l'IA peut les lire en complément, mais aucun skill n'en dépend.
