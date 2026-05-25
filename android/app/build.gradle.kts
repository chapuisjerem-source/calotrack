plugins {
    id("com.android.application")
    id("kotlin-android")
    // Le plugin Flutter Gradle doit être appliqué après les plugins Android et Kotlin.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.calotrack.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.calotrack.app"
        // minSdk 21 requis par mobile_scanner
        minSdk = 21
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Signature debug par défaut pour permettre `flutter run --release`
            // Remplacez par votre configuration de signature en production.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
