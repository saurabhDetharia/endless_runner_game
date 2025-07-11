import java.util.Base64

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val dartEnvironmentVariables: Map<String, String> = if (project.hasProperty("dart-defines")) {
    val defines = project.property("dart-defines") as String
    defines.split(",").associate { entry ->
        val decoded = String(Base64.getDecoder().decode(entry), Charsets.UTF_8)
        val (key, value) = decoded.split("=")
        key to value
    }
} else {
    emptyMap()
}

android {
    namespace = "com.example.endless_runner"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.endless_runner"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        manifestPlaceholders.putAll(
            mapOf(
                "GAD_APP_ID_ANDROID" to (dartEnvironmentVariables["GAD_APP_ID_ANDROID"] ?: "")
            )
        )


       /* // Add the manifest placeholder from dart-define
        manifestPlaceholders = [
            apiKey: decodedDefines.containsKey('GAD_APP_ID_ANDROID') ? decodedDefines['GAD_APP_ID_ANDROID'] : '',
        applicationName: "com.example.endless_runner",
        ]*/
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
