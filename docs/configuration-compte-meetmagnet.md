# Configuration Compte MeetMagnet

> Le tuto d'installation, étape par étape. Lisible par un humain, exécutable par une IA.
> Version 1 (septembre 2026). Les trois connecteurs sont séparés aujourd'hui ; ils seront probablement rassemblés plus tard.

## Si tu es une IA qui lit cette page

Tu accompagnes un utilisateur MeetMagnet dans l'installation. Suis les étapes dans l'ordre, une à la fois, donne-lui **le lien exact à coller** et attends qu'il te dise que c'est fait avant de passer à la suivante. À la fin, fais-lui le récapitulatif de la section « Récap : ce que tu peux faire maintenant ». Ne saute pas l'étape de test : c'est elle qui prouve que la connexion marche.

## Les trois outils

| Outil | Lien MCP | Compte utilisé | Pour quoi faire |
|---|---|---|---|
| **App MeetMagnet** | `https://app.meet-magnet.com/mcp` | Ton compte MeetMagnet | Prospects, séquences, conversations, ciblage, intentions |
| **StatUser** (Automatisation User) | `https://stats.meetmagnet.fr/api/mcp/claude-agent` | Ton compte StatUser | Stats, bilans, AgentOS (amélioration hebdo), pilotage des actions |
| **Recherche prospects** | `https://mcp.meetmagnet.fr/mcp` | Ton compte Google | Trouver des décideurs et des publications, même sans compte MeetMagnet |

Tu n'as pas besoin des trois pour commencer. Choisis selon ton cas :

- **Client MeetMagnet** : App (obligatoire) + StatUser (fortement conseillé).
- **Pas encore client, tu veux tester la recherche** : Recherche prospects seul.
- **Agence qui gère plusieurs comptes** : App + StatUser, connectés **avec le compte du client** sur lequel tu travailles (un compte agence ne donne pas accès à tous les clients d'un coup).

## Étape 1 : ajouter les connecteurs dans ton assistant IA

Le chemin exact dépend de l'assistant. Voir [INSTALL.md](../INSTALL.md) pour Claude, ChatGPT, Mistral, Cursor et les autres. Le principe est toujours le même : **Paramètres → Connecteurs (ou MCP / Intégrations) → Ajouter un serveur MCP distant → coller l'URL → autoriser**.

Ajoute-les dans cet ordre :

### 1a. App MeetMagnet
1. Vérifie que l'intégration est disponible sur ton compte : [app.meet-magnet.com/settings/integrations-ai](https://app.meet-magnet.com/settings/integrations-ai)
2. Ajoute le connecteur avec `https://app.meet-magnet.com/mcp`, nomme-le `App MeetMagnet`.
3. Autorise avec ton compte MeetMagnet.
4. **Test** : « Montre-moi la configuration de mon persona MeetMagnet ». Tu dois voir ta cible, ton offre et tes intentions.

### 1b. StatUser
1. Vérifie que tu as un compte : [stats.meetmagnet.fr/dashboard](https://stats.meetmagnet.fr/dashboard). Sinon, demande-le à MeetMagnet.
2. Ajoute le connecteur avec `https://stats.meetmagnet.fr/api/mcp/claude-agent`, nomme-le `Automatisation User MeetMagnet`.
3. Autorise avec ton compte StatUser.
4. **Test** : « Fais-moi le bilan de mes réponses sur 30 jours ». Tu dois voir des réponses classées.

### 1c. Recherche prospects (optionnel)
1. Ajoute le connecteur avec `https://mcp.meetmagnet.fr/mcp`, nomme-le `Recherche prospects MeetMagnet`.
2. Autorise avec ton compte Google.
3. **Test** : « Trouve-moi 5 DRH de PME qui déploient un SIRH ».

## Étape 2 : installer les skills

Les skills sont des fiches d'instructions qui disent à l'IA **comment** utiliser MeetMagnet correctement (comment définir un signal d'achat, comment répondre à un prospect, comment analyser un compte…). Sans eux, l'IA a les outils mais pas la méthode.

Le dossier `skills/` de ce repo contient 7 skills. Chaque skill est un dossier avec un fichier `SKILL.md`.

**Claude (app ou Claude Code)** : Paramètres → Skills → Ajouter → importer le dossier du skill (ou copier le dossier dans `~/.claude/skills/`). Tu peux aussi donner le lien du repo à Claude et lui demander de les installer.

**ChatGPT** : crée un Projet ou un GPT, colle le contenu de chaque `SKILL.md` dans les instructions (ou joins les fichiers au projet). Commence par [`skills/README.md`](../skills/README.md) qui explique quand utiliser quel skill.

**Mistral, autres** : même logique, colle les `SKILL.md` en instructions système ou en fichiers de connaissance.

Si tu ne veux en installer qu'un pour commencer : `analyse-meetmagnet` pour un client, `signaux-achat` pour la recherche.

## Étape 3 : vérifier que tout marche

Demande à ton assistant :

> « Fais le point sur mon compte MeetMagnet sur 30 jours. »

Il doit : appeler StatUser pour les chiffres, App pour la configuration et les conversations, et te rendre un rapport structuré (skill `analyse-meetmagnet`). S'il te demande de confirmer avant toute écriture, c'est bon signe.

## Récap : ce que tu peux faire maintenant

**Tous les jours (App)**
- « Quels prospects sont à valider ? Dis-moi lesquels correspondent et lesquels exclure. »
- « Qui m'a répondu ? Propose-moi une réponse pour chacun. »
- « Relance les conversations où j'ai proposé un créneau sans réponse. »

**Chaque semaine (StatUser)**
- « Bilan de la semaine : réponses, opportunités, ce qui marche. »
- « Qu'est-ce qu'AgentOS a proposé cette semaine ? Montre-moi l'avant / après. »
- « J'approuve, applique. » (rien ne change en production sans cette phrase)

**Quand tu veux améliorer le ciblage (App + skills)**
- « Propose-moi 3 nouvelles intentions d'achat pour ma solution. »
- « Réécris mes instructions de séquence en tutoiement, plus court. »
- « Pourquoi j'ai peu de réponses ? »

**Pour trouver de nouveaux prospects (Recherche prospects)**
- « Trouve-moi 10 directeurs financiers d'ETI qui préparent la facturation électronique, et écris un message d'accroche pour chacun. »
- « Ajoute les 3 meilleurs dans mon compte MeetMagnet. »

Plus d'exemples : [exemples-demandes.md](exemples-demandes.md). Quel skill s'active quand : [routage-skills.md](routage-skills.md).

## Les trois règles de sécurité

1. **Rien ne s'envoie, ne se valide ni ne se modifie sans ton « oui » explicite.** L'IA montre, tu décides, elle applique.
2. **Chaque connecteur voit un seul compte.** Pour un autre compte, reconnecte avec ce compte.
3. **Les intentions marquées ⚠️ PERFORMANTE ne se désactivent pas** sans ton accord.

## Problèmes fréquents

| Symptôme | Cause probable | Solution |
|---|---|---|
| « Je ne vois pas d'outils MeetMagnet » | Connecteur pas activé dans la conversation | Active-le dans la liste des connecteurs de la conversation |
| 401 / 403 sur la Recherche prospects | Compte Google non autorisé, ou endpoint admin avec un compte standard | Utilise `/mcp`, pas `/mcp/admin-search` ; demande le rôle partenaire si besoin |
| « Quota atteint » sur la recherche | 50 prospects à vie en mode standard | Demande le mode partenaire à contact@meet-magnet.com |
| L'IA ne trouve pas mon persona | Plusieurs personas ou mauvais compte connecté | « Liste mes personas accessibles », puis précise l'email |
| AgentOS refuse de lancer le cycle | Déjà lancé cette semaine | Normal, une fois par semaine. « Montre-moi les propositions » |
