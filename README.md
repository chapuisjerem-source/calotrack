# CaloTrack

Application mobile Android pour suivre ses calories et macronutriments au quotidien.
Développée en Flutter, pensée pour un usage simple et rapide.

## Fonctionnalités

- **Scanner de code-barres** via la caméra (EAN-13, EAN-8, UPC-A, UPC-E) avec récupération automatique des aliments depuis Open Food Facts.
- **Base locale d'aliments** (~200 produits courants en français) pour une recherche hors-ligne instantanée.
- **Saisie manuelle** d'aliments personnalisés avec leurs valeurs nutritionnelles.
- **Journal quotidien** groupé par repas (petit-déjeuner, déjeuner, collation, dîner) avec swipe pour supprimer.
- **Dashboard** avec un anneau animé de calories et des barres de progression pour les macros (protéines / glucides / lipides).
- **Historique 7 jours** avec graphique à barres et objectif caloriques, plus un suivi de poids avec courbe d'évolution.
- **Profil utilisateur** avec calcul automatique du TDEE (Mifflin-St Jeor) et objectifs personnalisés selon l'activité et le but (perte, maintien, prise).
- **Mode sombre** complet (suit le système par défaut).
- **Favoris** et **récents** pour accélérer la saisie.

## Prérequis

- Flutter 3.24 ou plus récent (Dart 3.5+)
- Android Studio Hedgehog ou plus récent
- Un émulateur Android ou un appareil physique avec API 21+ (Android 5.0)

Vérifier l'installation :

```bash
flutter doctor
```

## Installation

```bash
# 1. Cloner / copier le projet dans votre espace de travail
cd calotrack

# 2. Récupérer les dépendances
flutter pub get

# 3. Générer le code Drift (tables, DAO, etc.)
dart run build_runner build --delete-conflicting-outputs

# 4. Lancer sur un appareil connecté
flutter run
```

> Astuce : au premier lancement, Android Studio peut proposer « Run configuration `main.dart` » — acceptez.

## Structure du projet

```
lib/
├── main.dart                      # Point d'entrée (ProviderScope, portrait)
├── app.dart                       # MaterialApp.router + thèmes
├── core/                          # Code transversal (indépendant des features)
│   ├── constants/                 # Couleurs, endpoints API
│   ├── errors/                    # Classes Failure (sealed)
│   ├── router/                    # GoRouter + redirection onboarding
│   ├── theme/                     # Thèmes Material 3 light / dark
│   └── utils/                     # Dates, calculs TDEE
├── data/
│   ├── local/                     # Drift (tables, seed, DB)
│   ├── remote/                    # API Open Food Facts + DTO
│   └── repositories/              # Food / Meal / User / Weight
├── features/
│   ├── onboarding/                # Assistant profil en 6 étapes
│   ├── dashboard/                 # Journal + anneau calories + macros
│   ├── add_food/                  # Scanner / recherche / saisie / quantité
│   ├── history/                   # Graphiques 7 jours + suivi de poids
│   └── profile/                   # Consultation et édition du profil
└── shared/
    └── widgets/
        └── main_shell.dart        # Navigation bottom bar persistante
```

## Architecture

- **MVVM + Repository pattern** : les `ViewModel` (Riverpod `StateNotifier`) exposent un état typé aux écrans, les `Repository` encapsulent Drift et l'API.
- **Riverpod 2.x** pour l'injection de dépendances et la réactivité (`StreamProvider`, `FutureProvider`, `StateNotifierProvider`).
- **Drift (SQLite)** pour la persistance locale, avec seed de 200 aliments à la création.
- **go_router 14.x** avec `ShellRoute` pour garder la barre de navigation entre Journal / Historique / Profil.
- **Sealed classes `Failure`** pour typer proprement les erreurs réseau et produit.

## Permissions Android

L'application demande uniquement :

- `CAMERA` : pour scanner les codes-barres.
- `INTERNET` : pour appeler Open Food Facts quand un produit n'est pas en cache local.

## Build release

```bash
flutter build apk --release
# ou
flutter build appbundle --release
```

Pour signer le build en production, créez `android/key.properties` et remplacez le bloc `signingConfig` dans `android/app/build.gradle.kts`.

## Notes de développement

- La base SQLite est stockée dans le répertoire privé de l'application (via `drift_flutter`). Elle n'est pas partagée entre utilisateurs et est effacée à la désinstallation.
- Le calcul du TDEE utilise Mifflin-St Jeor pour le BMR, un multiplicateur d'activité (1.2 → 1.9) et un ajustement de ±500 kcal selon l'objectif.
- Les macros sont réparties : 2 g de protéines / kg de poids, 25 % de lipides sur les calories totales, le reste en glucides.

Bon suivi et bonne app !
