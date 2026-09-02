---
name: linkedin-recherche-intention
description: "Conçoit des requêtes LinkedIn, Google et IA (booléennes ou thématiques) pour détecter les publications d'un persona au bon moment commercial, à partir d'une solution, de personas et de signaux d'achat."
---

# Skill — Recherche LinkedIn par intention

## Mission

Produire des requêtes de recherche **courtes, naturelles, actionnables et hiérarchisées** afin de détecter des publications LinkedIn de personnes correspondant au persona cible, lorsqu'un contexte révèle un besoin probable pour la solution.

Le skill ne cherche pas les personnes qui parlent de la solution elle-même. Il cherche les **situations, priorités, frictions et changements** qui précèdent le besoin de cette solution chez un futur client final.

La sortie distingue toujours :

- **MOMENT** : un événement, une action ou une décision publiée qui rapproche d'un achat.
- **INTEREST** : un sujet suivi, commenté ou partagé qui indique une préoccupation ou une curiosité.

## Entrées attendues

- `SOLUTION` : ce qui est vendu, sa valeur et le problème métier résolu.
- `PERSONAS` : 1 à 5 intitulés de fonctions de décideurs, utilisateurs ou prescripteurs.
- `BONS_MOMENTS` : exemples de déclencheurs commerciaux, s'ils sont fournis.
- `MARCHÉ / PAYS / LANGUE` : facultatif. Par défaut, produire des formulations françaises adaptées aux publications LinkedIn en France.
- `OBJECTIF` : `MOMENT`, `INTEREST` ou `MIXTE`. Par défaut : `MIXTE`.

## Principe central : ne pas booléaniser par réflexe

La syntaxe doit servir l'intention de détection, pas démontrer une maîtrise des opérateurs.

| Signal recherché | Syntaxe prioritaire | Pourquoi |
|---|---|---|
| Intérêt autour d'un thème très niche | 1 mot-clé naturel | Le mot est déjà discriminant ; ajouter des contraintes réduit inutilement le volume |
| Intérêt autour d'un thème large et très bruyant | 2 à 3 mots-clés sans opérateur | Le croisement sémantique donne un sujet plus qualifié sans exiger un événement précis |
| Intérêt autour de plusieurs formulations voisines | 2 à 3 requêtes courtes séparées | Ne pas transformer tous les synonymes en une requête booléenne lourde |
| Moment avant achat, annoncé explicitement | Booléen avec verbe d'action + contexte | Il faut relier une action observable à l'objet qui crée le besoin |
| Moment avant achat avec plusieurs verbes plausibles | `(verbe OR verbe) AND contexte` | Les verbes varient, mais l'événement et son contexte doivent coexister |
| Moment stratégique indirect | Booléen léger : changement + fonction, processus ou enjeu | Il capte les déclencheurs sans sur-contraindre le texte |

**Règle décisive :** utiliser un booléen lorsque les deux concepts doivent impérativement apparaître ensemble pour faire sens commercialement. Sinon, préférer une requête thématique naturelle.

Exemple :

- Pour une solution de gestion de flotte, `"véhicules électriques"` peut suffire à capter un intérêt de niche.
- `"intelligence artificielle"` est beaucoup trop vaste : préférer `"IA" "service client"`, `"automatisation" "support client"` ou `"agent IA" "relation client"` selon le cas.
- Pour un moment avant achat, rechercher `( "recrutons" OR "recherche" ) AND "responsable service client"` : l'action de recruter et le poste doivent coexister.

## Étape 1 — Comprendre la mécanique d'achat

Avant toute requête, traduire la solution en quatre éléments :

1. **Résultat acheté** : quel résultat business, opérationnel, financier, technique ou réglementaire le client cherche-t-il ?
2. **Problèmes amont** : quelles difficultés le prospect peut-il exprimer sans nommer la solution ?
3. **Déclencheurs** : quels événements rendent le problème urgent ou plus coûteux ?
4. **Vocabulaire de publication** : quels mots un client final emploierait-il naturellement sur LinkedIn, sans reprendre le jargon du fournisseur ?

Formuler mentalement la chaîne suivante :

`Événement observable → nouvelle contrainte / ambition → problème accru → valeur de la solution`

Ne jamais produire une requête si cette chaîne n'est pas plausible.

## Étape 2 — Écarter les faux positifs structurels

La cible est un **client final payant**. Éviter les requêtes centrées sur :

- Le nom ou la catégorie exacte de la solution, lorsqu'ils attirent fournisseurs, éditeurs, intégrateurs, agences ou consultants.
- Les métiers qui vendent, implémentent ou recommandent habituellement la solution.
- Les formulations techniques trop produit qui font remonter des concurrents et partenaires.
- Les contenus génériques de leadership ou de tendance sans rapport avec une tension métier observable.

Préférer :

- Le résultat métier : `"réduire les impayés"` plutôt que `"logiciel de recouvrement"`.
- Le changement opérationnel : `"nouveau marché"` + `"équipe commerciale"` plutôt que `"outil de prospection"`.
- La friction vécue : `"trop de demandes"` + `"support"` plutôt que `"helpdesk"`.

Si une requête a une probabilité élevée de faire remonter un concurrent ou un partenaire, la réécrire à partir du **problème, de l'événement ou du résultat client**.

## Étape 3 — Classer le type de signal

### INTEREST : une préoccupation ou un sujet suivi

Utiliser `INTEREST` lorsque la personne est susceptible de publier, commenter ou interagir autour d'un sujet relié à son besoin, mais sans action d'achat identifiable.

Types d'intérêt :

- Problème opérationnel : délais, surcharge, qualité, pertes, erreurs, recrutement difficile.
- Objectif : croissance, amélioration de marge, industrialisation, satisfaction client, productivité.
- Évolution de pratique : IA appliquée, nouvelle méthode, organisation, process, outil complémentaire.
- Pression externe : conformité, cybersécurité, réglementation, concurrence, sobriété, pénurie.
- Écosystème : salon métier, formation, conférence, benchmark, retour d'expérience.

#### Choisir la longueur d'une requête INTEREST

Évaluer la **densité** du sujet :

- **Niche** : terme rare, métier précis, technologie ou objet concret peu polysémique. Utiliser 1 mot ou 1 expression courte.
  - Exemples : `"pergola"`, `"facturation électronique"`, `"mécatronique"`.
- **Intermédiaire** : sujet connu mais contextuel. Utiliser 2 mots-clés.
  - Exemples : `"délais paiement"`, `"recrutement commercial"`, `"données clients"`.
- **Bruyant / vaste** : terme très employé, abstrait ou transversal. Utiliser 2 à 3 mots-clés avec un contexte métier, sans booléen obligatoire.
  - Exemples : `"intelligence artificielle" "service client"`, `"SEO" "e-commerce"`, `"automatisation" "équipe finance"`.

Pour un INTEREST, ne pas utiliser `AND` uniquement par habitude. Une recherche composée de deux ou trois expressions successives est souvent plus naturelle et suffisamment précise dans LinkedIn ou dans un moteur sémantique.

### MOMENT : un changement ou une action qui précède l'achat

Utiliser `MOMENT` lorsque la publication est susceptible de contenir une action concrète, récente et reliée au besoin :

- Recrutement ou création d'équipe.
- Lancement de produit, service, offre, site, marché, filiale ou pays.
- Levée de fonds, investissement, acquisition, fusion, changement de direction.
- Déploiement, migration, audit, appel d'offres, changement de process.
- Croissance commerciale, nouveaux clients, hausse de volume, expansion géographique.
- Incident, contrainte réglementaire, cybersécurité, conformité ou difficulté opérationnelle.
- Participation à un salon, une formation ou un benchmark très ciblé.

Un MOMENT doit comporter au moins :

- un **verbe d'action** ou une formule événementielle ;
- un **contexte métier** (équipe, processus, marché, fonction, contrainte ou objet).

C'est le cas d'usage privilégié des opérateurs booléens.

## Étape 4 — Construire les requêtes

### Banque de verbes MOMENT

Choisir les verbes qui sont réellement plausibles dans une publication du persona :

- Recrutement : `"recrutons"`, `"recherche"`, `"nous recrutons"`, `"rejoignez"`.
- Lancement : `"lancement"`, `"lançons"`, `"déployons"`, `"mise en place"`.
- Croissance : `"ouverture"`, `"expansion"`, `"accélération"`, `"nouveau marché"`.
- Transformation : `"migration"`, `"refonte"`, `"structuration"`, `"industrialisation"`.
- Évaluation : `"appel d'offres"`, `"benchmark"`, `"audit"`, `"comparatif"`.
- Tension : `"conformité"`, `"audit"`, `"incident"`, `"retard"`, `"surcharge"`.

Ne pas chercher des verbes invraisemblables ou trop formels. Adapter les verbes au ton LinkedIn : `"on recrute"`, `"nouvelle étape"`, `"heureux d'annoncer"`, `"cap franchi"` peuvent être plus fréquents que le langage administratif.

### Patrons booléens MOMENT

Ne retenir que les patrons qui conservent 3 à 4 concepts maximum. Chaque terme entre guillemets est une expression naturelle et chaque requête doit rester lisible.

```text
("verbe 1" OR "verbe 2") AND "contexte"
("verbe 1" OR "verbe 2") AND "enjeu"
"verbe" AND "fonction"
"verbe" AND "processus"
"événement" AND "contexte"
("événement 1" OR "événement 2") AND "contexte"
("verbe" AND "contexte") OR ("verbe" AND "enjeu")
```

Exemples de forme, à adapter sans copier les mots :

```text
("recrutons" OR "recherche") AND "responsable recouvrement"
("lancement" OR "ouverture") AND "nouveau marché"
("déployons" OR "mise en place") AND "nouveau processus"
("levée de fonds" OR "accélération") AND "équipe commerciale"
"audit" AND "conformité"
```

### Patrons INTEREST non booléens

```text
"terme niche"
"problème" "contexte"
"objectif" "fonction"
"sujet large" "cas d'usage" "métier"
"pression externe" "processus"
```

Exemples de forme :

```text
"facturation électronique"
"délais de paiement" "PME"
"IA" "relation client"
"SEO" "e-commerce"
"cybersécurité" "données clients"
```

## Étape 5 — Générer un portefeuille de 10 requêtes

Pour une demande standard `MIXTE`, générer exactement 10 requêtes classées par valeur commerciale :

- 5 requêtes **MOMENT**, majoritairement booléennes, dont 2 à intention forte, 2 à intention moyenne et 1 plus large.
- 5 requêtes **INTEREST**, non booléennes sauf nécessité claire, dont 2 sujets très ciblés, 2 sujets intermédiaires et 1 sujet large contextualisé.

Si l'utilisateur demande explicitement `MOMENT`, générer 8 MOMENT et 2 INTEREST de validation. Si l'utilisateur demande `INTEREST`, générer 8 INTEREST et 2 MOMENT faibles ou moyens permettant d'anticiper la bascule vers l'achat.

### Ordre de priorité

Classer les requêtes selon :

1. Proximité entre le signal et une décision d'achat.
2. Probabilité qu'un client final publie réellement avec ces mots.
3. Capacité de la requête à exclure naturellement les fournisseurs et partenaires.
4. Rapport précision / volume : ni trop vague, ni si étroite qu'elle ne produit presque aucun résultat.
5. Cohérence avec les responsabilités du persona.

## Contrôle qualité obligatoire

Avant de rendre la liste, vérifier chaque requête :

- Elle est écrite dans la langue attendue et avec des termes qu'un humain publierait.
- Elle vise un client final, non un concurrent, une agence, un intégrateur ou un consultant.
- Elle ne contient pas plus de 3 à 4 concepts utiles.
- `AND` relie deux éléments qui doivent coexister ; `OR` regroupe uniquement de vrais synonymes, variantes ou actions concurrentes.
- Les guillemets entourent des termes ou expressions de recherche ; les opérateurs sont en majuscules.
- Une recherche INTEREST niche n'a pas été artificiellement alourdie.
- Une recherche INTEREST très large comporte au moins un contexte métier supplémentaire.
- Une recherche MOMENT contient une action ou un événement et son contexte.
- Les 10 requêtes ne sont pas des doublons maquillés avec des synonymes.
- La requête ne mentionne pas directement la solution si cela attire principalement l'écosystème vendeur.

## Prompt opérationnel

Utiliser le texte ci-dessous comme prompt utilisateur pour l'agent de génération.

```text
Tu es un expert des recherches LinkedIn, Google et IA orientées signaux d'achat.

Ta mission : générer exactement 10 requêtes de recherche classées par potentiel commercial afin de détecter des publications d'un PERSONA qui pourrait bientôt avoir besoin d'une SOLUTION.

SOLUTION :
{{ $('GetPersona').item.json.Solution }}

PERSONAS qui publient sur LinkedIn :
{{ $('persona').item.json.output.personas[0]['Métier1'] }},
{{ $('persona').item.json.output.personas[1]['Métier2'] }},
{{ $('persona').item.json.output.personas[2]['Métier3'] }},
{{ $('persona').item.json.output.personas[3]['Métier4'] }},
{{ $('persona').item.json.output.personas[4]['Métier5'] }}

Exemples de bons moments déjà identifiés :
{{ $json.output.toJsonString() }}

OBJECTIF : {{ $json.objectif || 'MIXTE' }}

Méthode obligatoire :
1. Déduis le résultat métier de la SOLUTION, les problèmes amont, les événements déclencheurs et les formulations naturelles qu'un client final emploie sur LinkedIn.
2. Ne recherche jamais la SOLUTION elle-même si cela risque d'attirer concurrents, intégrateurs, agences, consultants ou partenaires. Cherche les problèmes, résultats, contraintes et événements vécus par le client final.
3. Classe chaque idée en MOMENT ou INTEREST.
4. Pour MOMENT : privilégie une requête booléenne courte qui associe un verbe d'action ou événement à un contexte métier. Utilise AND seulement si les deux éléments doivent coexister. Utilise OR seulement pour de vrais synonymes, variantes ou verbes alternatifs.
5. Pour INTEREST : n'utilise PAS de booléen par défaut. Choisis la longueur selon la densité du sujet :
   - thème niche et peu polysémique : 1 mot-clé ou expression courte ;
   - thème de densité intermédiaire : 2 mots-clés naturels ;
   - thème vaste ou bruyant : 2 à 3 mots-clés contextualisés par un métier, un processus ou un cas d'usage.
6. Garde 3 à 4 concepts maximum par requête. Utilise des guillemets pour les termes ou expressions. Écris AND et OR en majuscules. Utilise des parenthèses seulement quand elles clarifient réellement la logique.
7. Pour un objectif MIXTE, rends 5 MOMENT et 5 INTEREST. Pour MOMENT : 8 MOMENT et 2 INTEREST. Pour INTEREST : 8 INTEREST et 2 MOMENT.
8. Varie les niveaux de maturité : requêtes très précises, intermédiaires et plus larges. Classe d'abord les signaux qui indiquent le besoin le plus proche et le plus actionnable.
9. Vérifie que chaque requête est plausible dans une publication LinkedIn du persona, ne ressemble pas à du jargon fournisseur et n'est pas un doublon.

Réponds uniquement avec un JSON valide, sans Markdown ni explication, au format exact :
{
  "searches": [
    {
      "rank": 1,
      "type": "MOMENT",
      "intent_strength": "FORT",
      "query": "(\"verbe\" OR \"variante\") AND \"contexte\""
    }
  ]
}
```

## Règle de sortie

Lorsque ce skill est invoqué, ne fournir que le JSON demandé par le prompt opérationnel. Ne jamais expliquer la méthode, ajouter de commentaires, ni inclure de texte avant ou après le JSON.