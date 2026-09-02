# skill-meetmagnet

**Utiliser MeetMagnet depuis n'importe quel assistant IA** (Claude, ChatGPT, Mistral, Cursor…) : les liens de connexion, le tuto d'installation, et les skills qui apprennent à l'IA comment prospecter correctement.

Ce repo se lit à deux niveaux :
- **Humain** : tu veux brancher MeetMagnet sur ton assistant et savoir quoi lui demander. Commence par [docs/configuration-compte-meetmagnet.md](docs/configuration-compte-meetmagnet.md).
- **IA** : on t'a donné ce lien pour guider un utilisateur. Lis [AGENTS.md](AGENTS.md), puis suis le tuto d'installation étape par étape.

> **Version 1 (septembre 2026).** Trois connecteurs séparés aujourd'hui. Ils seront probablement rassemblés en un seul plus tard ; la doc évoluera avec.

## Les trois connecteurs en 30 secondes

| Outil | Lien MCP à coller | Compte | Pour quoi |
|---|---|---|---|
| **App MeetMagnet** | `https://app.meet-magnet.com/mcp` | Ton compte MeetMagnet ([activer ici](https://app.meet-magnet.com/settings/integrations-ai)) | Prospects, séquences, conversations, ciblage, intentions |
| **StatUser** | `https://stats.meetmagnet.fr/api/mcp/claude-agent` | Ton compte StatUser ([dashboard](https://stats.meetmagnet.fr/dashboard)) | Stats, bilans, AgentOS, pilotage des actions |
| **Recherche prospects** | `https://mcp.meetmagnet.fr/mcp` | Ton compte Google ([site](https://mcp.meetmagnet.fr/)) | Trouver des décideurs et des publications, sans compte MeetMagnet |

Installation détaillée par assistant : [INSTALL.md](INSTALL.md).

## Les 7 skills

Un skill = une fiche d'instructions qui donne la **méthode** à l'IA. Les connecteurs donnent les outils, les skills disent comment s'en servir.

| Skill | En une phrase |
|---|---|
| [`signaux-achat`](skills/signaux-achat/SKILL.md) | Définir de vrais signaux d'achat (MOMENT / INTEREST) plutôt que des mots-clés |
| [`linkedin-recherche-intention`](skills/linkedin-recherche-intention/SKILL.md) | Écrire les requêtes LinkedIn qui détectent ces signaux |
| [`redaction-message-prospection`](skills/redaction-message-prospection/SKILL.md) | Rédiger un message à partir d'un signal, sans « j'ai vu que tu as liké » |
| [`conversation-b2b-rdv`](skills/conversation-b2b-rdv/SKILL.md) | Transformer une réponse de prospect en rendez-vous confirmé |
| [`prompt-sequence-meetmagnet`](skills/prompt-sequence-meetmagnet/SKILL.md) | Produire les instructions de séquence à coller dans MeetMagnet |
| [`analyse-meetmagnet`](skills/analyse-meetmagnet/SKILL.md) | Faire le point sur un compte : chiffres, config, conversations, plan |
| [`meetmagnet-execute`](skills/meetmagnet-execute/SKILL.md) | Exécuter les actions planifiées, avec vérification avant chaque envoi |

Quel skill quand, et comment ils s'enchaînent : [docs/routage-skills.md](docs/routage-skills.md).

## Ce que tu pourras demander

```
Trouve-moi 10 DAF d'ETI qui préparent la facturation électronique, avec un message pour chacun.
Quels prospects sont à valider ? Dis-moi lesquels correspondent et lesquels exclure.
Qui m'a répondu ? Propose-moi une réponse pour chacun.
Fais le point sur mon compte sur 30 jours.
Pourquoi j'ai peu de réponses ?
Propose-moi 3 nouvelles intentions d'achat et les recherches LinkedIn qui vont avec.
Réécris mes instructions de séquence en tutoiement, plus court.
Qu'est-ce qu'AgentOS a proposé cette semaine ? … OK, j'approuve, applique.
```

Plus d'exemples commentés : [docs/exemples-demandes.md](docs/exemples-demandes.md).

## Les trois règles

1. **Rien ne s'envoie, ne se valide ni ne se modifie sans ton « oui » explicite.** L'IA montre, tu décides, elle applique.
2. **Chaque connecteur voit un seul compte.** Un compte agence ne pilote pas tous ses clients d'un coup : pour un autre compte, reconnecte avec ce compte.
3. **Les intentions marquées ⚠️ PERFORMANTE ne se désactivent pas** sans ton accord.

## Structure du repo

```
README.md                          ← tu es ici
AGENTS.md                          ← instructions pour une IA qui lit ce repo
INSTALL.md                         ← ajouter un MCP dans Claude, ChatGPT, Mistral, Cursor…
docs/
  configuration-compte-meetmagnet.md   ← le tuto pas à pas + récap final
  mcp-app-meetmagnet.md                ← lien, connexion, outils, workflows
  mcp-statuser.md                      ← idem pour StatUser / AgentOS
  mcp-recherche-prospects.md           ← idem pour la recherche
  routage-skills.md                    ← quel skill quand, et pourquoi
  exemples-demandes.md                 ← demandes réelles commentées
skills/
  README.md                            ← index des skills
  signaux-achat/                       ← SKILL.md + references/
  linkedin-recherche-intention/
  redaction-message-prospection/
  conversation-b2b-rdv/
  prompt-sequence-meetmagnet/
  analyse-meetmagnet/                  ← SKILL.md + references/
  meetmagnet-execute/
scripts/
  rename.sh                            ← cloner sous un autre nom (marque blanche)
```

## Cloner sous un autre nom (marque blanche)

Tu es une agence ou un partenaire et tu veux la même doc sous ton nom (ex. NeoResilia) ?

```bash
git clone https://github.com/MeetMagnet/skill-meetmagnet.git skill-neoresilia
cd skill-neoresilia
./scripts/rename.sh NeoResilia
```

Le script renomme la marque dans tous les fichiers et dossiers (`MeetMagnet` → `NeoResilia`, `meetmagnet` → `neoresilia`, `meet-magnet` → `neoresilia`) et les skills (`analyse-meetmagnet` → `analyse-neoresilia`…). Les URL de connexion restent celles de MeetMagnet par défaut, puisque c'est la même plateforme derrière ; pour les changer aussi :

```bash
./scripts/rename.sh NeoResilia \
  --app-url https://app.neoresilia.fr/mcp \
  --stats-url https://stats.neoresilia.fr/api/mcp/claude-agent \
  --search-url https://mcp.neoresilia.fr/mcp \
  --contact contact@neoresilia.fr
```

Détail : [scripts/rename.sh](scripts/rename.sh).

## Contribuer

Les skills évoluent avec l'usage. Une demande qui marche bien, un cas qui coince, un skill manquant : ouvre une issue ou une PR. Garde le principe : lisible par un humain, exécutable par une IA, jamais d'écriture sans validation.

Licence : MIT. Contact : contact@meet-magnet.com.
