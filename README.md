# SocialSpot Mobile Frontend

Application Flutter pour SocialSpot : accès internet gratuit après validation de publicités.

## Fonctionnalités principales

- Inscription (nom, prénom, email)
- Vérification OTP + création de mot de passe
- Connexion (email + mot de passe)
- Accès internet contrôlé par le backend (timer 20 min)
- Renouvellement d’accès via validation de publicité
- Gestion des permissions (localisation, WiFi)
- Thème moderne et responsive

## Démarrage rapide

### Prérequis

- Flutter 3.x
- Un backend SocialSpot fonctionnel (Node.js/Prisma)
- Un appareil Android/iOS ou un émulateur

### Installation

1. Cloner le dépôt :

   ```sh
   git clone <repo-url>
   ```

2. Installer les dépendances :

   ```sh
   flutter pub get
   ```

3. Générer les fichiers nécessaires :

   ```sh
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. Lancer l’application :

   ```sh
   flutter run -d <device>
   ```

### Pour le web (démo)

- Lancer avec :

  ```sh
  flutter run -d chrome
  ```

- Certaines fonctionnalités natives (WiFi, permissions) sont simulées ou désactivées.

## Structure du projet

- `lib/pages/` : pages principales (welcome, signup, home, etc.)
- `lib/services/` : accès API, gestion session, etc.
- `lib/models/` : modèles de données
- `lib/helpers/` : couleurs, styles, routes
- `lib/widgets/` : composants UI réutilisables

## Bonnes pratiques

- Respect du MVVM (ViewModel, Provider)
- Gestion des erreurs utilisateur et backend
- Thème cohérent sur toutes les pages

## Dépendances principales

- flutter_riverpod
- dio
- shared_preferences
- permission_handler
- gap
- google_fonts

## Backend requis

- Voir le dossier `backend_socialspot_prisma_nodemailer` pour l’API Node.js/Prisma
- L’URL backend doit être configurée dans les services (`http://localhost:4000/api` par défaut)

## Aide & Support

Pour toute question ou bug, ouvrez une issue ou contactez l’équipe SocialSpot.

---

© 2025 SocialSpot. Tous droits réservés.
