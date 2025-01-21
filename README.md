# e_library

**e_library** est une application mobile cross-platform développée en Flutter qui permet d'afficher des listes d'étagères et les livres qu'elles contiennent. Ce projet a été réalisé dans le cadre d'un test technique.

---

## Table des matières

- [Fonctionnalités](#fonctionnalités)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Choix Techniques](#choix-techniques)
- [Améliorations et Fonctionnalités Supplémentaires](#améliorations-et-fonctionnalités-supplémentaires)
- [Tests](#tests)
- [API Utilisée](#api-utilisée)
- [Déploiement](#déploiement)

---

## Fonctionnalités

1. **Affichage des étagères** :
   - Liste des étagères récupérées via une API.
   - Chaque étagère affiche son nom et le nombre de livres qu'elle contient.
2. **Affichage des livres d'une étagère** :
   - Vue en grille des livres après sélection d'une étagère.
   - Informations affichées pour chaque livre :
     - Couverture
     - Titre
     - Auteur(s) 
     - ...
3. **Navigation intuitive** entre la liste des étagères et les livres.
4. **Pagination** pour gérer les listes volumineuses.
5. **Changement de thème** : Possibilité de basculer entre le mode clair et sombre.


---

## Prérequis

- Flutter SDK version 3.6.0 ou supérieure.
- Android Studio ou Xcode pour le développement mobile.


---

## Installation

1. Clonez ce dépôt :
   ```bash
   git clone <lien-du-depot>
   cd e_library
   ```
2. Installez les dépendances :
   ```bash
   flutter pub get
   ```
3. Lancez l'application :
   ```bash
   flutter run
   ```

---

## Utilisation

- **Navigation** :
  - La page d'accueil affiche la liste des étagères.
  - Cliquez sur une étagère pour afficher ses livres.
- **Recherche** :
  - Utilisez la barre de recherche pour filtrer les livres par titre ou auteur.
- **Thème** :
  - Sur la page d'acceuil, cliquez sur le bouton dans le coin superieur droit pour changer entre le mode clair et sombre.

---

## Choix Techniques

### Packages Utilisés

- **`adaptive_theme`** :
  - Utilisé pour implémenter le changement de thème (clair/sombre) de manière fluide.
  - Permet de sauvegarder le préférence utilisateur.

- **`dio`** :
  - Gère les appels API avec des options avancées comme les interceptors et une gestion efficace des erreurs.

- **`either_dart`** :
  - Simplifie la gestion des erreurs et des résultats dans les appels API.

- **`get`** :
  - Fournit une gestion de l'état et une navigation intuitive sans surcharge de code.

- **`infinite_scroll_pagination`** :
  - Implémenté pour la pagination des listes d'étagères et de livres, garantissant une bonne performance.

- **`logger`** :
  - Utilisé pour le débogage et la journalisation des événements dans l'application.

- **`shimmer_animation`** :
  - Crée des effets visuels attrayants pour les états de chargement.

### Performances

- Les **ListView.builder** ont été utilisés pour les listes d'étagères et de livres afin de minimiser l'utilisation de mémoire et améliorer les performances sur les grandes listes.
-  Optimisation des performances avec des listes paginées.

---

## Améliorations et Fonctionnalités Supplémentaires

- Ajout d'animations fluides pour améliorer l'expérience utilisateur.
- Recherche en temps réel.
- Mode clair/sombre


---

## Tests

Des tests unitaires ont été ajoutés pour valider les fonctionnalités principales :
- L'affichage des informations d'un livre

Pour exécuter les tests :
```bash
flutter test
```

---

## API Utilisée

Base de l'API : `https://api.glose.com`

1. **Liste des étagères** :
   - Endpoint : `GET /users/5a8411b53ed02c04187ff02a/shelves`
   - Paramètres : `offset`, `limit`
2. **Liste des livres** :
   - Endpoint : `GET /shelves/:shelfId/forms`
   - Paramètres : `shelfId`, `offset`, `limit`
3. **Détails d'un livre** :
   - Endpoint : `GET /forms/:formId`
   - Paramètre : `formId`

---

## Déploiement


- **(iOS)** : Une vidéo demo est disponible a ce [lien](https://youtube.com/shorts/Jiykyi6Ipdc).
- **Play Console** (Android) : Accédez a l'application sur play Store en tant que testeur interne en suivant ce [Lien](https://play.google.com/apps/internaltest/4701365308279037380).  



