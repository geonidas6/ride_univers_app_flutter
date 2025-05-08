# RideUnivers - Application Flutter

RideUnivers est une application sociale pour les cyclistes, permettant de partager ses parcours, défis et expériences avec la communauté.

## Fonctionnalités

- Authentification (inscription, connexion)
- Profil utilisateur
- Parcours et défis
- Événements et tournois
- Messagerie
- Publication de posts
- Gestion des amis

## Prérequis

- Flutter SDK (version >=3.0.0)
- Dart SDK (version >=3.0.0)
- Android Studio / Xcode pour les émulateurs
- Git

## Installation

1. Clonez le dépôt :
```bash
git clone https://github.com/votre-username/riderunivers.git
cd riderunivers/RideUniversAppFlutter
```

2. Installez les dépendances :
```bash
flutter pub get
```

3. Générez les fichiers nécessaires :
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Configuration

1. Créez un fichier `.env` à la racine du projet avec les variables suivantes :
```
API_URL=https://api.riderunivers.com
GOOGLE_MAPS_API_KEY=votre_clé_api_google_maps
```

2. Configurez les clés d'API pour Google Maps :
- Android : Ajoutez votre clé dans `android/app/src/main/AndroidManifest.xml`
- iOS : Ajoutez votre clé dans `ios/Runner/AppDelegate.swift`

## Exécution

Pour lancer l'application en mode debug :
```bash
flutter run
```

Pour générer une version release :
- Android : `flutter build apk`
- iOS : `flutter build ios`

## Architecture

L'application suit les principes de Clean Architecture avec une structure en couches :

```
lib/
  ├── core/           # Composants centraux (erreurs, réseau, etc.)
  ├── features/       # Fonctionnalités de l'application
  │   ├── auth/      # Authentification
  │   ├── profile/   # Profil utilisateur
  │   ├── ride/      # Parcours
  │   └── ...
  ├── shared/        # Composants partagés
  └── main.dart      # Point d'entrée de l'application
```

## Tests

Pour exécuter les tests :
```bash
flutter test
```

## Contribution

1. Fork le projet
2. Créez une branche pour votre fonctionnalité (`git checkout -b feature/nouvelle-fonctionnalite`)
3. Committez vos changements (`git commit -m 'Ajout d'une nouvelle fonctionnalité'`)
4. Push vers la branche (`git push origin feature/nouvelle-fonctionnalite`)
5. Ouvrez une Pull Request

## Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails. 