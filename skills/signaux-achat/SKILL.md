---
name: signaux-achat
description: >
  Génère des signaux d'achat (MOMENT et INTEREST) de haute qualité pour la recherche de prospects LinkedIn.
  À utiliser dès qu'il faut construire des typed_search_signals pour search_prospects /
  admin_search_visible_prospects (MCP Recherche prospects MeetMagnet), définir ou améliorer les
  intentions d'achat d'un compte MeetMagnet (create_intent / update_intent, MCP App MeetMagnet),
  qualifier des prospects selon leur niveau d'intention d'achat, ou rédiger la description naturelle
  d'un signal dans un message commercial. Décrit les signaux comme un humain (jamais "a liké un post"),
  en appliquant la méthodologie EKB/TRA/TPB/Howard-Sheth pour identifier les vrais déclencheurs d'achat.
---

# Skill : Signaux d'Achat

Ce skill te donne la méthodologie et les règles pour générer, qualifier et décrire des signaux d'achat LinkedIn de haute qualité — que ce soit pour alimenter une recherche de prospects ou rédiger la description d'un signal dans un email commercial.

---

## Les deux types de signaux

### MOMENT — Moment avant achat
Une **action réalisée et partagée** dans une publication LinkedIn qui révèle **indirectement** un besoin probable à court ou moyen terme.

C'est un **événement observable** : recrutement, lancement de projet, participation à un salon, déploiement d'un outil, changement de stratégie. La personne ne cherche pas encore activement la solution, mais son action annonce un besoin.

**Niveaux :**
- **Faible** : action qui pourrait potentiellement mener à un besoin dans un futur lointain (ex : publie sur la transformation digitale en général)
- **Moyen** : action qui suggère un besoin prochain (ex : annonce le lancement d'un nouveau service commercial)
- **Fort** : action qui révèle directement un besoin ou une phase de décision active (ex : recrute un credit manager, déploie un ERP, lance un appel d'offres)

### INTEREST — Signal d'intérêt
Une **interaction passive** (like, commentaire, partage d'article) sur des contenus liés à la problématique que résout la solution.

C'est un **marqueur de curiosité ou de préoccupation** : la personne consomme des contenus sur le sujet, même si elle n'a pas encore bougé.

**Niveaux :**
- **Absence** : aucune interaction sur le sujet
- **Faible** : interactions génériques sur des thèmes larges du domaine
- **Modéré** : interactions répétées sur des contenus liés à la problématique ou à des solutions concurrentes
- **Fort** : interactions spécifiques, répétées, sur des problématiques précises et des solutions comparables

---

## Méthode pour générer des signaux de qualité

À partir du **métier cible** et de la **solution vendue**, génère des signaux en appliquant ces 5 grilles d'analyse :

### 1. Modèle EKB — Parcours d'achat
- Quelles actions publiées correspondent à une étape du parcours : reconnaissance du besoin, recherche d'information, évaluation d'alternatives ?
- Quels comportements observables précèdent la prise de conscience du problème ?

### 2. Théorie de l'Action Raisonnée (TRA)
- Quelles publications ou interactions traduisent une attitude ou une norme sociale qui prédisent l'intérêt pour la solution ?
- Quels signaux faibles (partage d'article métier, question dans un commentaire) suggèrent un cheminement intellectuel vers le besoin ?

### 3. Théorie du Comportement Planifié (TPB)
- Quelles actions manifestent une intention de changement ou une ouverture à de nouveaux outils ?
- Participation à un webinaire, sollicitation de feedback, comparaison publique de solutions : quelles interactions révèlent une progression vers l'achat ?

### 4. Modèle Howard-Sheth — Stimuli exogènes
- Quels changements organisationnels publiés (recrutement, restructuration, nouveau projet, internationalisation) génèrent un besoin ?
- Comment un contexte de croissance, de conformité réglementaire ou d'optimisation prépare-t-il la décision d'achat ?

### 5. Variables d'influence
- Quelles situations individuelles (pression de performance, changement de poste) ou environnementales (évolution sectorielle, pression concurrentielle) structurent la probabilité d'achat ?
- Quels signes latents révèlent un besoin non encore verbalisé (questionnement sur les tendances, demande d'avis) ?

---

## Construire les typed_search_signals

Pour chaque recherche de prospects, génère 3 à 5 signaux en mélangeant MOMENT et INTEREST selon le niveau de maturité attendu.

**Règles de construction :**
- Préférer des signaux spécifiques (ex : "recrutement d'un responsable recouvrement") plutôt que génériques (ex : "finance")
- Mélanger des signaux de niveaux différents pour capter un spectre large de maturité
- Les MOMENT capturent les prospects en phase active — les prioriser si la solution adresse un besoin urgent
- Les INTEREST capturent les prospects en phase de réflexion — utiles pour créer du pipeline à moyen terme

**Format pour search_prospects / admin_search_visible_prospects :**
```json
[
  { "label": "recrutement d'un credit manager ou responsable recouvrement", "type": "MOMENT" },
  { "label": "lancement d'une politique de crédit client", "type": "MOMENT" },
  { "label": "gestion des impayés et créances clients", "type": "INTEREST" },
  { "label": "optimisation du besoin en fonds de roulement", "type": "INTEREST" }
]
```

**Pour une intention dans le compte MeetMagnet (App, `create_intent`) :** un signal = une intention avec `label`, `type` (INTEREST ou MOMENT), `subjects`, `verbs`, `products`, puis 1 à 3 recherches LinkedIn (`create_search`) écrites avec le skill `linkedin-recherche-intention`. Lis toujours `get_intent_config_skill` avant de créer. Maximum 15 intentions actives par persona ; un compte bien configuré en a au moins 5 dont 3 INTEREST et 3 MOMENT.

---

## Décrire un signal dans un email commercial

Ne jamais écrire "a liké", "a posté sur", "like sur un post". Traduire le signal en langage humain.

### Si le signal est un INTEREST (like, commentaire)
Décrire l'intérêt de façon naturelle, en synthétisant le sujet du contenu :
- "S'intéresse à la réduction des délais de paiement et à la gestion des créances clients"
- "Suit de près les évolutions réglementaires sur la facturation électronique"
- "S'intéresse aux outils d'automatisation de la prospection commerciale"

Ne pas citer le contenu du post mot pour mot. Synthétiser le sujet pour montrer la préoccupation sous-jacente.

### Si le signal est un MOMENT (publication)
Décrire l'action concrète réalisée et ce qu'elle révèle :
- "A récemment lancé une initiative pour structurer la politique de crédit client de son entreprise"
- "Publie sur les enjeux du recouvrement en entreprise industrielle et partage son retour d'expérience"
- "A annoncé le déploiement d'un nouvel ERP au sein de son équipe finance"

Si le postSummary contient une action concrète (a recruté, a lancé, a déployé), la reformuler naturellement. Si c'est une réflexion ou un partage d'opinion, utiliser "publie sur" ou "s'engage sur le sujet de".

### Exemples comparatifs

Mauvais : "Like sur un post Credit Management"
Bon : "S'intéresse à la gestion des créances et à la réduction des délais de paiement"

Mauvais : "Publication sur la plantation d'arbres"
Bon : "A récemment planté 500 arbres avec son équipe dans le cadre d'un projet RSE"

Mauvais : "Like sur un post recouvrement"
Bon : "Suit les pratiques de recouvrement amiable en entreprise B2B"

Mauvais : "Poste sur l'IA en prospection"
Bon : "Partage son expérience sur l'intégration de l'IA dans les processus commerciaux"

---

## Exemples de signaux par domaine

Voir le fichier references/exemples-par-domaine.md pour des exemples détaillés par secteur.

Pour un nouveau domaine, applique la méthode des 5 grilles ci-dessus en te demandant :
1. Quel événement professionnel observable précède typiquement l'achat de cette solution ?
2. Quels sujets LinkedIn un prospect en phase de réflexion likerait-il ?
3. Quelle pression externe (réglementation, concurrence, croissance) crée le besoin ?

---

## Filtrage qualité des résultats de recherche

Après une recherche de prospects, appliquer ces critères :

**Exclure :**
- Profils sans entreprise identifiée
- Profils hors France (sauf cible internationale explicite)
- Titres juniors (stagiaire, assistant junior, étudiant)
- Consultants/freelances/coachs (même si non capturés par exclude_jobs)

**Prioriser :**
- Signaux de niveau FORT et MOYEN sur les signaux FAIBLE
- Entreprises de taille cohérente avec la solution vendue
- Profils avec entreprise et secteur clairement identifiés
