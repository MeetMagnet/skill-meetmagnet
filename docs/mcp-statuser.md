# MCP StatUser (Automatisation User MeetMagnet)

> Les statistiques, le bilan, l'amélioration continue (AgentOS) et le pilotage des actions prospect par prospect.

| | |
|---|---|
| **Lien MCP à coller** | `https://stats.meetmagnet.fr/api/mcp/claude-agent` |
| **Tableau de bord web** | [stats.meetmagnet.fr/dashboard](https://stats.meetmagnet.fr/dashboard) |
| **Connexion** | Ton compte StatUser. Tu ne vois que tes comptes. |
| **Nom conseillé du connecteur** | `Automatisation User MeetMagnet` (ou `StatUser MeetMagnet`) |

## Comment se connecter

1. Ouvre [stats.meetmagnet.fr/dashboard](https://stats.meetmagnet.fr/dashboard) et connecte-toi avec ton compte StatUser (si tu n'en as pas, demande-le à MeetMagnet).
2. Dans ton assistant IA, ajoute un connecteur MCP distant avec l'URL `https://stats.meetmagnet.fr/api/mcp/claude-agent`. Voir [INSTALL.md](../INSTALL.md).
3. Autorise l'accès avec ton compte StatUser.
4. Teste : « Liste mes comptes MeetMagnet accessibles » (`list_accessible_personas`).

## Ce que tu peux faire

### 1. Regarder un compte
- `list_accessible_personas` : tes comptes.
- `resolve_persona` : retrouver un persona par email ou identifiant.
- `get_stats_replies` : les réponses, déjà classées (intérêt, pas maintenant, déjà équipé, refus…). StatUser synchronise et vérifie que l'analyse a bien été faite.
- `get_stats_opportunities` : qui veut un échange ou un rendez-vous, à quel stade.
- `get_stats_feedbacks` : les retours négatifs et les exclusions.
- `get_stats_messages` : les messages envoyés et corrigés.
- `get_stats_positioning` : le ciblage marche-t-il ? (volume contre qualité)
- `get_stats_intents` : quelles intentions ramènent des prospects et des réponses.
- `get_stats_report` / `analyze_stats_period` : un bilan (cette semaine, ce mois, 30 jours…). `analyze_stats_period` pour un livrable lisible.
- `get_stats_continuous_improvement`, `get_stats_agentos` : ce que l'amélioration continue a produit.

### 2. AgentOS, la semaine
AgentOS analyse ton compte chaque semaine et propose des changements de configuration (ciblage, intentions, messages).

- « Qu'est-ce qui a été proposé cette semaine ? » → `list_agentos_proposals` : chaque changement en avant / après.
- « J'accepte » ou « on garde l'actuel » → `decide_agentos_proposal` : ça enregistre, **ça n'écrit pas encore**.
- « OK, j'approuve, applique » → `apply_agentos_proposals` avec `confirmApply: true` : **là seulement, ça part en production.** Sans cette phrase claire, rien ne change côté MeetMagnet.
- Lancer le cycle de la semaine → `launch_agentos_cycle` : une seule fois par semaine (s'il a déjà tourné, l'assistant te le dit).
- Allumer ou éteindre le mode auto → `get_agentos_auto_mode` / `set_agentos_auto_mode` :
  - `autoAnalysis` : analyses auto (dimanche)
  - `autoApply` : mise en prod auto sans relecture (à n'activer que si tu es à l'aise)
  - `autoSync` : chiffres à jour tout seuls
- « Montre-moi le run » → `get_agentos_run` : tous les journaux.

### 3. Le quotidien (messages, prospects)
Le pilotage action par action, avec un Planner (qui propose) et un Executor (qui exécute). Le skill `meetmagnet-execute` couvre la partie exécution.

- `get_agent_config` : la configuration de l'agent du persona (actif ? consignes ? capacités ?).
- `get_planning_lot` : les prospects encore à traiter, avec une situation et une suggestion d'action.
- `propose_actions` : préparer des messages, relances, validations, archivages (non confirmés). Retourne un bloc de revue à relire.
- `revise_actions`, `confirm_actions` : corriger puis confirmer, après relecture.
- `list_due_actions`, `next_due_action` : les actions dues.
- `get_prospect_state`, `set_auto_running` : allumer ou éteindre le pilotage auto d'un prospect.
- `complete_action` (« c'est fait »), `fail_action` (« ça a planté »), `cancel_action`.

## Ce que l'assistant ne peut pas faire

- Voir les comptes des autres.
- Appliquer un changement sans que tu confirmes.
- Relancer un deuxième cycle AgentOS la même semaine si le premier a déjà abouti.

## Le bon réflexe, en 3 temps

1. **On regarde** (stats, propositions, actions dues)
2. **On décide** (accepte / refuse)
3. **On applique** (« vas-y, j'approuve »)

## Skills liés

- `analyse-meetmagnet` : le bilan complet, croisé avec l'App.
- `meetmagnet-execute` : exécuter les actions planifiées et confirmées, avec vérification avant chaque écriture.

Voir [exemples-demandes.md](exemples-demandes.md).
