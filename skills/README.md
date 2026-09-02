# Les skills MeetMagnet

Chaque dossier contient un `SKILL.md` : une fiche d'instructions qu'une IA lit pour savoir quand et comment agir. Le format est celui des skills Claude (front-matter `name` + `description`, puis le corps), mais le contenu est du Markdown lisible par n'importe quel assistant : ChatGPT, Mistral, Cursor, ou un humain.

| Skill | Sert à | Se déclenche sur | Connecteurs |
|---|---|---|---|
| [`signaux-achat`](signaux-achat/SKILL.md) | Définir des signaux d'achat MOMENT / INTEREST de qualité, pour une recherche ou pour les intentions d'un compte | « signaux d'achat », « intentions », « typed_search_signals », « quels prospects chercher » | Recherche prospects, App |
| [`linkedin-recherche-intention`](linkedin-recherche-intention/SKILL.md) | Écrire les requêtes LinkedIn (booléennes ou thématiques) qui détectent ces signaux | « requêtes LinkedIn », « recherche booléenne », « mots-clés » | App (create_search) |
| [`redaction-message-prospection`](redaction-message-prospection/SKILL.md) | Rédiger un message de prospection à partir d'un signal (post liké, publié, mention) | « écris un message », « accroche », « relance », « message LinkedIn » | aucun obligatoire |
| [`conversation-b2b-rdv`](conversation-b2b-rdv/SKILL.md) | Transformer une conversation avec un prospect en rendez-vous confirmé | « réponds-lui », « il m'a dit », « comment décrocher le RDV » | App |
| [`prompt-sequence-meetmagnet`](prompt-sequence-meetmagnet/SKILL.md) | Produire le prompt d'instructions de séquence à coller dans MeetMagnet | « instructions de séquence », « configure mes messages », « change le ton » | App |
| [`analyse-meetmagnet`](analyse-meetmagnet/SKILL.md) | Faire le point complet sur un compte : chiffres, config, conversations, plan | « fais le point », « bilan », « pourquoi peu de réponses » | StatUser + App |
| [`meetmagnet-execute`](meetmagnet-execute/SKILL.md) | Exécuter les actions planifiées et confirmées, avec vérification avant chaque écriture | « meetmagnet-execute email », « exécute les actions dues » | StatUser + App |

Comment ils s'enchaînent : [docs/routage-skills.md](../docs/routage-skills.md).

## Installer

**Claude** : copie chaque dossier dans `~/.claude/skills/` (Claude Code) ou importe-le via Paramètres → Skills (app Claude). Ou donne le lien du repo à Claude : « installe les skills de ce repo ».

**ChatGPT / Mistral / autres** : colle le contenu des `SKILL.md` dans les instructions d'un projet, ou joins-les comme fichiers de connaissance. Ajoute ce README en premier pour que l'assistant sache lequel lire selon la demande.

## Convention

- Front-matter YAML : `name` (identifiant en kebab-case) et `description` (quand se déclencher, écrite pour l'IA).
- Le corps : le rôle, les entrées, la méthode étape par étape, les règles, les raccourcis.
- Dossier `references/` optionnel pour les annexes longues.
- Aucun skill n'écrit dans MeetMagnet sans validation explicite de l'utilisateur.
