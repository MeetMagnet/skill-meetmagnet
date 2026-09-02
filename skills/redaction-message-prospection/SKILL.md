---
name: redaction-message-prospection
description: Skill de rédaction de messages de prospection B2B personnalisés (LinkedIn, email) à partir de signaux d'affaires (posts likés, publiés, ou mentions), s'appuyant sur les modèles scientifiques du comportement d'achat (EKB, TRA, TPB, Howard-Sheth) pour construire une accroche, extraire l'information pertinente, puis rédiger un message respectant un template imposé avec variables entre accolades, chevrons et crochets. À utiliser systématiquement dès que l'utilisateur demande de rédiger un message de prospection, un message d'accroche, une accroche commerciale, un message de prise de contact, un message LinkedIn ou email de prospection, une relance, ou tout message destiné à un prospect à partir d'un signal (like, post, mention). Toujours utiliser ce skill pour ce type de demande, même sans le mot "prospection" explicite, dans n'importe quel projet.
---

# Rédaction de message de prospection B2B (signal-based)

## Objectif

Transformer un signal d'affaires (like, publication, mention/lien) concernant un prospect en un message de prospection court, percutant et humain, en respectant strictement une méthode en 3 étapes : 1) travailler l'accroche, 2) récupérer et vérifier l'information pertinente, 3) rédiger le message final en respectant template, accolades, chevrons et crochets. Ne jamais sauter une étape. Ne jamais halluciner une information absente : si une donnée manque, appliquer une hypothèse raisonnable simple plutôt que de refuser de produire le message. Le message doit TOUJOURS être généré, même imparfait.

---

## Définitions théoriques : signaux d'achat et moments avant achat

### Signal d'achat d'intérêt — définition générale

Un signal d'achat d'intérêt est un indicateur ou un ensemble d'indicateurs qui suggèrent qu'un prospect pourrait être intéressé par une solution en fonction de ses activités de recherche, de navigation, d'interaction, de citation ou de publication. Ces signaux varient en intensité (directs/indirects) et reflètent le niveau d'intérêt/maturité du prospect dans son parcours d'achat.

### Niveaux de signal d'achat d'intérêt

| Niveau | Description | Exemple |
|---|---|---|
| Absence de signal | Aucun indicateur ne suggère un besoin ou un intérêt pour la solution | Pas de recherche, pas d'interaction, pas de mention de problématique liée |
| Signal faible | Quelques indices très généraux montrent un intérêt potentiel, mais rien de précis ni répété | Recherche sur des termes larges du domaine sans précision, visite de pages généralistes |
| Signal modéré | Plusieurs indicateurs ou interactions spécifiques à la solution ou à des problématiques proches | Interaction sur des contenus/posts concurrents, mention de termes techniques liés, participation à des discussions thématiques |
| Signal fort | Indicateurs clairs, répétés et spécifiques d'un intérêt prononcé pour la solution et les problématiques qu'elle résout | Recherche sur des besoins précis, publication de problématiques spécifiques, demande de recommandations, engagement actif envers des solutions semblables |

### Moment avant achat — définition générale

Un moment avant achat est une action réalisée et partagée dans une publication ou une citation qui montre indirectement que la personne ayant réalisé l'action pourrait avoir besoin de la solution prochainement. C'est un indicateur (ou ensemble d'indicateurs) direct ou indirect qui permet d'estimer le niveau de maturité du prospect dans son parcours d'achat.

### Niveaux de moment avant achat

| Niveau | Description |
|---|---|
| Faible | Action ou publication montrant indirectement que le prospect pourrait potentiellement avoir besoin de la solution dans un temps futur |
| Moyen | Action ou publication montrant indirectement que le prospect pourrait avoir besoin de la solution très prochainement |
| Fort | Action ou publication montrant directement un besoin pour la solution, ou indiquant qu'il pourrait être résolu par la solution maintenant |

---

## Contexte de la prospection à toujours exploiter

Avant de rédiger, exploiter précisément ces deux éléments de contexte, disponibles dans les données d'entrée :

- Activité LinkedIn du prospect : le type d'activité exact (ex. aimé, publié, identifié) indique comment le prospect a interagi récemment avec une publication LinkedIn. Formuler explicitement ce contexte en interne avant de rédiger sur ce modèle : « Le prospect a récemment [activité] une publication LinkedIn. »
- Contenu du post : le texte intégral de la publication, généralement fourni entre guillemets. C'est la seule source de vérité sur le sujet à mentionner. Ne jamais aller chercher un sujet hors de ce contenu.

Ces deux éléments doivent systématiquement nourrir l'étape 1 et rester vérifiables à l'étape 3.

---

## Étape 1 — Qualifier le signal et construire l'accroche

### 1.1 Identifier le type de signal

| Type de signal | Signification | Règle d'attribution |
|---|---|---|
| aimé / liké | INTÉRÊT — le prospect a aimé le post d'un tiers | Ne jamais attribuer l'action au prospect. Partir du sujet du post, pas de l'action. Un like est un intérêt, ce n'est pas une réflexion. |
| publié / posté | MOMENT — le prospect a lui-même écrit ou partagé | Rebondir sur ce que le prospect a fait ou ce qui lui arrive. Compliment autorisé. |
| identifié / en lien avec / a été identifié | LIEN — mention contextuelle | Information de contexte uniquement, aucune action directe attribuée au prospect. |

Erreur interdite : si un prospect aime un post sur une action réalisée par quelqu'un d'autre, ne jamais écrire « votre projet de X ». Écrire plutôt une phrase générique sur le sujet suivie d'une question d'ouverture.

### 1.2 Extraire le sujet exact du post

Identifier le sujet précis du contenu (post LinkedIn, article, citation). Utiliser les termes exacts du post dans toutes les formulations, jamais un terme générique qui édulcore le sujet.

### 1.3 Construire le stimulus d'accroche avec les modèles scientifiques du comportement d'achat

S'appuyer sur le modèle EKB, la théorie de l'action raisonnée (TRA), la théorie du comportement planifié (TPB), le modèle Howard-Sheth et les variables d'influence pour analyser le signal avec rigueur. Ces 5 grilles de lecture s'appliquent aussi bien pour qualifier un signal d'intérêt que pour qualifier un moment avant achat.

#### 1. Modèle EKB

- Quelles recherches ou interactions observables illustrent une étape du parcours de décision du prospect : reconnaissance du besoin, recherche d'information, évaluation d'alternatives ?
- Quels signaux d'intérêt peuvent précéder ou accompagner la prise de conscience du problème ?
- Pour un moment avant achat : quelles actions publiées constituent une étape observable du processus d'achat ? Quelles activités décrivent un point d'entrée dans la reconnaissance du besoin, la recherche d'informations ou la phase d'évaluation ?

#### 2. Théorie de l'Action Raisonnée (TRA)

- Quelles recherches ou comportements traduisent une attitude, une norme sociale ou une intention qui prédisent l'intérêt pour la solution ?
- Quels signaux faibles ou implicites suggèrent un cheminement intellectuel vers le besoin ?
- Pour un moment avant achat : quelles actions traduisent une attitude, une norme sociale ou une intention qui rend probable une recherche active de solution ?

#### 3. Théorie du Comportement Planifié (TPB)

- Comment des actions manifestent-elles une intention, une ouverture au changement ou un contrôle comportemental perçu susceptibles de déboucher sur l'achat ?
- Quelles interactions sont révélatrices de la progression vers l'achat : analyse comparative, participation à des webinaires, prise de contact avec des experts ?
- Pour un moment avant achat : quelles actions affichent une posture d'ouverture ou une capacité à faire évoluer les habitudes, les outils ou les ressources ?

#### 4. Modèle Howard-Sheth

- Quels types de stimuli sectoriels, de changements d'activité, d'évaluation de solutions ou de benchmarking public peuvent générer un besoin ?
- Comment l'engagement observé dans des processus métiers, des phases de transformation ou des discussions autour de problématiques précises révèle-t-il un moment de maturité ?
- Pour un moment avant achat : quels stimuli exogènes favorisent l'émergence d'un besoin ? Comment un contexte de transformation, d'optimisation ou d'innovation prépare-t-il la décision d'achat ?

#### 5. Variables d'influence

- Quelles situations individuelles, environnementales ou psychologiques structurent la probabilité qu'un signal soit suivi d'une action d'achat ?
- Quels signes d'intérêt latent existent : questionnements sur les tendances, demande explicite d'avis, signalement d'enjeux techniques ou organisationnels ?
- Pour un moment avant achat : quelles variables contextuelles (croissance, modernisation, conformité, optimisation) structurent la probabilité qu'une action publiée précède un besoin ?

Note méthodologique : ces questions guident le raisonnement interne. Elles ne sont pas censées apparaître littéralement dans l'accroche.

### 1.4 Classer le signal

- Signal d'intérêt : absence / faible / modéré / fort.
- Moment avant achat : faible / moyen / fort.

### 1.5 Rédiger l'accroche

Toujours croiser 3 éléments : le prospect, la solution vendue et le signal. Adapter problématiques, exemples et gains au métier et à la headline du prospect.

Démarche :
1. Vérifier que l'intérêt ou le stimulus principal est pertinent au regard du signal.
2. Préciser ce stimulus si possible pour renforcer la pertinence.
3. Confirmer que ce stimulus relie prospect, solution et signal.

Format : maximum 400 caractères, structuré en 2 points : 1) résumé du stimulus par rapport au signal, 2) pourquoi ce stimulus est pertinent. Ne rien ajouter d'autre.

---

## Étape 2 — Extraire l'information pertinente

### 2.1 Règle absolue : pas d'invention

Si une information est absente, incertaine ou non vérifiable, répondre `null`.

### 2.2 Normalisation des champs

- Métier simplifié : toujours en minuscules.
- Nom d'entreprise : casse titre propre, retirer les slogans et sous-titres.
- Nom / prénom incomplets : si incomplet, ne pas les utiliser dans la formule d'appel.
- Phrases courtes : toujours découper une phrase longue en deux phrases courtes.

### 2.3 Application de la règle typeContent

- Branche LIKÉ : interdiction des compliments.
- Branche PUBLIÉ : compliment autorisé.

### 2.4 Données à collecter systématiquement

- Prospect : nom, prénom, civilité, métier, headline, description, entreprise, secteur, tagline, langue.
- Vendeur : nom, solution vendue, problématiques adressées.
- Signal : type d'activité, résumé de l'activité, contenu intégral du post.
- Accroche validée à l'étape 1.

Traiter chaque variable individuellement comme un prompt séparé et répondre uniquement avec les valeurs extraites.

---

## Étape 3 — Rédiger le message

### 3.1 Respect du template

Respecter le template d'exemple : structure, ton, longueur, politesse, ouverture, signature et retours à la ligne. Si aucun exemple n'est fourni, utiliser un template court : Bonjour + accroche + lien avec la problématique/solution + question ouverte ou CTA soft + signature si nécessaire.

### 3.2 Traitement des variables entre accolades { }

- Type 1 : remplacer directement par la valeur.
- Type 2 : exécuter l'instruction conditionnelle et rédiger la phrase résultante.

### 3.3 Traitement des chevrons < >

Le contenu entre chevrons contient des consignes à exécuter. Si un élément est une URL LinkedIn, la copier-coller sans modification.

### 3.4 Traitement des crochets [ ]

- Crochets simples : copier mot pour mot le texte puis retirer les crochets.
- Doubles crochets : exécuter l'instruction et rédiger la phrase correspondante.

### 3.5 Gestion de l'URL

Si une URL est fournie, elle doit être incluse obligatoirement. Sinon, ne jamais en insérer.

### 3.6 Anti-répétition

Ne jamais réutiliser la même tournure, la même formule d'ouverture ou le même angle argumentatif qu'un message précédent.

### 3.7 Auto-vérification avant envoi

1. Langue = langue du prospect uniquement.
2. Aucun mot interdit.
3. Chaque accolade a été remplacée.
4. Chaque crochet a été traité.
5. Chaque chevron a été traité.
6. Aucune tournure identique à un message précédent.
7. Mise en forme conforme à l'exemple.
8. Formules de politesse, salutation et signature conformes.

### 3.8 Contrat de sortie

Toujours générer un message. Ne jamais dire qu'il manque des informations. Répondre uniquement avec le texte du message.

---

## Consignes de rédaction pour un message impactant

### Ce qu'il ne faut jamais faire

- Éviter l'auto-promotion immédiate : ne pas présenter le vendeur en début de message.
- Bannir les phrases génériques.
- Ne pas supposer que le prospect connaît déjà son problème.
- Éviter la sur-généralisation.
- Un like est un intérêt, pas une réflexion.
- Ne pas présenter le produit comme une solution magique.
- Ne pas faire de promesses irréalistes.
- Ne pas ignorer le parcours d'achat.
- Ne pas écrire de manière superflue.
- Ne pas adopter un ton trop formel, pompeux ou trop enthousiaste.
- Ne pas répéter les informations déjà mentionnées dans un précédent message.
- Ne pas ajouter de signature si l'exemple n'en contient pas.
- Ne pas utiliser les mots ou tournures suivants : « Tu as aimé… », « Tu as liké… », « En tant que passionné(e) de… », « J'ai adoré le post de… », « J'ai été submergé par… », « Ton avis était incroyable… », « Votre publication est inspirante… », « C'est vraiment inspirant », « Je suis impressionné », « J'ai lu avec intérêt ton post LinkedIn ».

### Les bonnes pratiques pour un message impactant

- Rédiger le message dans la langue exacte imposée.
- Donner une impression humaine.
- Utiliser des emojis avec parcimonie 🤗.
- Ne pas inclure d'objet.
- S'appuyer uniquement sur des informations sûres et pertinentes.
- Remplacer tous les placeholders génériques.
- Poser des questions ouvertes.
- Faire référence à un élément précis de la publication LinkedIn.
- Apporter une valeur immédiate.
- Centrer la discussion sur le prospect.
- Écrire naturellement et simplement.
- Faire des phrases courtes.
- Varier les angles d'approche entre les relances.
- S'assurer que chaque message est autonome.
- Créer une vraie conversation.

Objectif final : un message ultra-court, engageant et pertinent qui donne envie au prospect de répondre sans se sentir prospecté.

---

## Résumé du flux complet

1. Qualifier le signal et le sujet exact.
2. Analyser via EKB, TRA, TPB, Howard-Sheth et variables d'influence.
3. Classer le signal ou le moment avant achat.
4. Construire l'accroche.
5. Extraire les informations prospect / vendeur / signal.
6. Rédiger le message final en résolvant accolades, chevrons et crochets.
7. Appliquer les bonnes pratiques et les interdits.
8. Vérifier qu'il ne reste aucun symbole résiduel.
9. Sortir uniquement le texte du message.
