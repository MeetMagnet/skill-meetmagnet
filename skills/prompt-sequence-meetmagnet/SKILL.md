---
name: prompt-sequence-meetmagnet
description: "Rédige le prompt d'instructions de séquence à coller dans MeetMagnet (champ « instructions de séquence », rédaction V2) : style, tutoiement, tonalité, accroche, pitch, preuve sociale, signature, interdits, architecture J+0 / J+14 / J+30. Part de la configuration du persona (MCP App MeetMagnet) et de ce que l'utilisateur fournit (notes, exemples de messages, consignes). Peut aussi produire les instructions de conversation (replyInstructions). Se déclenche sur \"prompt de séquence\", \"instructions de séquence\", \"prompt messages\", \"configure mes messages\", \"améliore mes messages MeetMagnet\", ou dès qu'on demande de définir comment MeetMagnet doit écrire les messages de prospection."
---

# Prompt d'instructions de séquence MeetMagnet

## Ce que produit ce skill

Un seul livrable : un prompt en français, dans un bloc de code, prêt à être collé dans le champ « instructions de séquence » de MeetMagnet (ou poussé via `update_persona_config`, champ `sequenceInstructions`). Ce prompt s'adresse à l'IA MeetMagnet qui rédigera les messages de prospection. Il décrit le style de l'utilisateur, ce qu'il faut faire, ce qu'il est interdit de faire, et l'architecture de la séquence message par message.

Ce skill ne rédige pas les messages eux-mêmes. Pour rédiger un message à partir d'un signal, c'est le skill `redaction-message-prospection` qui s'applique ; ses principes (signal liké vs publié, pas d'auto-promotion, phrases courtes, une seule question, interdits) servent de socle aux consignes produites ici.

## Prérequis

MCP **App MeetMagnet** connecté (`https://app.meet-magnet.com/mcp`). Avant de toucher à la configuration des messages, appelle `get_message_config_skill` : il explique la rédaction V2 (`sequenceGenerationV2`, `sequenceInstructions`, `replyInstructions`) et la V1 (templates).

Ce skill ne suppose **aucun CRM, aucun outil de compte rendu, aucune boîte mail**. Tout ce qui n'est pas dans la configuration persona vient de l'utilisateur.

## Arguments

`{consigne libre}` et, si l'utilisateur gère plusieurs comptes, `{email du compte}`.

Exemple : `tutoiement systématique, pas d'email, mettre en avant le cas client Acme`. La consigne prime toujours sur ce que dit la configuration existante ; signale l'écart à la fin.

## Phase 1 — Collecte

Ne rédige rien avant d'avoir terminé.

**A. Configuration existante (MCP App MeetMagnet)** — `get_persona_config`. Relève : prénom, nom, poste et entreprise du vendeur, `sellerSex`, offre (`solution`), problématiques (`problem`), site, cible (métiers, secteurs, tailles, localisations), `messageTone`, et le contenu actuel de `sequenceInstructions` / `replyInstructions` s'il existe. Ignore les templates V1 (`messageTemplates`). Ne modifie rien.

**B. Ce que l'utilisateur fournit.** Demande-lui, en un seul message, ce qui manque parmi :
- 2 ou 3 messages qu'il a déjà envoyés et dont il est content (les vrais, copiés-collés)
- comment il présente son offre en une phrase, avec ses mots
- une preuve sociale citable (cas client, chiffre, nom autorisé) ou « aucune »
- ce qu'il refuse absolument (mots, tournures, ton)
- tutoiement, vouvoiement, ou selon le profil
- l'architecture souhaitée : canaux, nombre de messages, délais

**C. Le site web de l'utilisateur** (si `website` est renseigné et qu'un outil de lecture web est disponible) : lis la page d'accueil et une page offre pour caler le vocabulaire. Ne copie pas le marketing du site dans le prompt ; extrais les mots que l'utilisateur emploie vraiment.

## Phase 2 — La grille de style

Remplis cette grille avant d'écrire. Chaque ligne a une valeur, une source (persona, utilisateur, site, hypothèse) et, si c'est une hypothèse, la marque `[À CONFIRMER]`.

| Dimension | Ce que tu cherches | Si rien n'est trouvé |
|---|---|---|
| Enjeu global | Ce que l'utilisateur attend de la séquence (RDV qualifiés, gagner du temps, notoriété) | Obtenir une réponse, pas vendre `[À CONFIRMER]` |
| Vendeur et signature | Prénom, poste, entreprise, sexe, comment il signe | Prénom seul sur LinkedIn, prénom + poste + entreprise sur email `[À CONFIRMER]` |
| Cible | Métiers, secteurs, tailles, localisations, exclusions | Persona config |
| Langue | Français, anglais, ou langue du prospect | Langue du prospect, français par défaut |
| Registre | Tutoiement, vouvoiement, ou selon profil (critères : secteur, ton du post, headline) | `messageTone` de la persona, sinon question |
| Tonalité | Directe, chaleureuse, experte, sobre, humour ; emojis oui/non | Exemples de messages de l'utilisateur, sinon question |
| Phrases et longueur | Nombre de lignes par message, retours à la ligne | Phrases courtes, 3 à 6 lignes LinkedIn, 6 à 10 lignes email |
| Accroche | Comment on entre en matière selon le signal (post liké vs publié) | Règles du skill `redaction-message-prospection` |
| Pitch | La phrase d'offre de l'utilisateur, les mots employés, les mots refusés | `solution` et `problem` reformulés `[À CONFIRMER]` |
| Preuve sociale | Cas clients citables, chiffres, logos | Aucune preuve inventée : « pas de preuve sociale chiffrée » |
| CTA | RDV, appel, échange, réponse simple, lien de prise de RDV ou non | Question ouverte au J+0, proposition d'échange à partir de la relance |
| Formulations interdites | Interdits de l'utilisateur + interdits standard | Liste standard ci-dessous |
| Exemples de messages | Messages réels de l'utilisateur | Aucun exemple inventé |
| Architecture | Canaux, nombre de messages, délais, objectif de chaque message | Toujours demander |

Interdits standard, à inclure dans tous les prompts : « Tu as aimé… », « Tu as liké… », « En tant que passionné(e) de… », « J'ai adoré le post de… », « Votre publication est inspirante », « C'est vraiment inspirant », « Je suis impressionné », « J'ai lu avec intérêt ton post LinkedIn », « J'espère que vous allez bien », « Je me permets de », auto-présentation en première phrase, promesse chiffrée non sourcée, mention du nom de l'outil de prospection, objet d'email racoleur, plus d'une question par message.

## Phase 3 — Les questions

Pose toutes tes questions en un seul message. Ne demande que ce qui manque réellement.

L'architecture est toujours à demander si elle n'est pas précisée. Formule la question avec une proposition concrète à valider : « LinkedIn J+0 dès l'acceptation de l'invitation, relance LinkedIn J+14, dernière relance J+30, pas d'email. Ça te va ? ».

Si l'utilisateur répond « fais au mieux », applique les valeurs par défaut de la grille et l'architecture LinkedIn J+0 / J+14 / J+30.

## Phase 4 — Rédaction du prompt

Le prompt est en français, à l'impératif, adressé à l'IA rédactrice. Chaque consigne est courte, concrète et vérifiable. Pas de placeholder : tout est renseigné avec les vraies valeurs. Pas de méta-commentaire dans le bloc.

Structure imposée, dans cet ordre :

```
# Instructions de séquence — {Prénom Nom, Entreprise}

## 1. Enjeu
Qui écrit, à qui, pourquoi. L'objectif de la séquence en une phrase (obtenir une réponse, pas vendre).

## 2. Vendeur et signature
Identité du vendeur telle qu'elle doit apparaître. Règle de signature par canal. Ce qu'on ne dit jamais sur le vendeur.

## 3. Cible
À qui on écrit : métiers, secteurs, tailles. Comment adapter le vocabulaire au métier du prospect.

## 4. Langue et registre
Langue. Règle de tutoiement / vouvoiement avec les critères si « selon profil ». Formule d'appel.

## 5. Tonalité et style
Adjectifs de tonalité avec un exemple de tournure pour chacun. Longueur par canal. Emojis. Ponctuation. Retours à la ligne.

## 6. Accroche
Comment ouvrir selon le signal : post publié par le prospect (rebondir sur ce qu'il a fait, compliment autorisé), post liké (parler du sujet, jamais attribuer l'action, pas de compliment). Ce que l'accroche cite obligatoirement. Longueur max.

## 7. Pitch
La phrase de pitch de référence. Le bénéfice à mettre en avant. Les mots à employer. Les mots à ne pas employer. Où placer le pitch (jamais en première phrase).

## 8. Preuve sociale
Les preuves citables mot pour mot. Les preuves interdites. Dans quel message les utiliser.

## 9. Appel à l'action
Le CTA par message. Une seule question par message. Formulations autorisées.

## 10. Formulations interdites
Interdits de l'utilisateur + interdits standard.

## 11. Architecture de la séquence
Pour chaque message : canal, délai (J+0 = dès l'acceptation de l'invitation LinkedIn ou dès l'ouverture de la séquence), objectif, structure ligne par ligne, longueur, angle imposé (chaque relance change d'angle : nouveau bénéfice, question différente, preuve, porte de sortie). Le dernier message ferme proprement sans pression.

## 12. Exemples de tonalité
Uniquement des messages réels fournis par l'utilisateur, cités tels quels. Sinon : « Pas d'exemple fourni : respecter strictement les sections 4 à 10 ».

## 13. Vérification avant sortie
Checklist appliquée à chaque message : langue, registre, aucun interdit, une seule question, longueur, signature conforme, accroche liée au signal, angle différent du message précédent, aucun placeholder.
```

Règles d'écriture :
- Reprends les mots de l'utilisateur. S'il a dit « je ne veux pas avoir l'air d'un commercial », la consigne devient « Ne jamais présenter l'offre avant la deuxième phrase, ne jamais employer les mots solution, accompagnement, expertise ».
- Une consigne vague est interdite. « Ton chaleureux » ne suffit pas : ajoute la tournure qui l'illustre.
- Chaque message de l'architecture doit être autonome.
- La preuve sociale n'est jamais inventée.
- Le prompt ne mentionne jamais MeetMagnet ni le fait qu'une IA rédige.

## Phase 5 — Livraison et vérification

Après le bloc de code, huit lignes maximum :
1. Sources utilisées (persona config, messages fournis, site, consigne).
2. Hypothèses `[À CONFIRMER]` restées dans le prompt.
3. Écarts entre la consigne et la configuration existante.
4. Ce que tu peux faire ensuite, sans le faire : pousser le prompt dans le compte (`update_persona_config` avec `sequenceGenerationV2: true` et `sequenceInstructions`), produire la version `replyInstructions` pour les conversations.

Avant de livrer, vérifie : 13 sections présentes, aucun placeholder, tous les interdits présents, architecture conforme à ce qui a été validé, aucune preuve ni exemple inventé, registre cohérent.

**N'écris jamais dans le compte MeetMagnet sans demande explicite.** Quand l'utilisateur dit « pousse-le », affiche ce qui va être écrit, attends « oui », puis appelle `update_persona_config`.

## Raccourcis

| Il dit | Tu fais |
|---|---|
| « passe en tutoiement » / « en vouvoiement » | Réécris la section 4 et harmonise les tournures des sections 5 à 9 |
| « ajoute l'email à J+7 » | Ajoute l'étape dans la section 11 avec objet, longueur et angle |
| « plus court » | Réduis les longueurs de la section 5 et la structure de chaque message de la section 11 |
| « pousse-le dans l'app » | `update_persona_config` avec `sequenceGenerationV2: true`, `sequenceInstructions` = le prompt, après confirmation |
| « fais les instructions de conversation » | Second prompt `replyInstructions`, même style, centré sur la gestion des réponses et la prise de RDV (skill `conversation-b2b-rdv`) |
