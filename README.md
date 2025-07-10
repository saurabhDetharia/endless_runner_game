# endless_runner

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Ad-Sense Setup

### Android:

In the Android project, you need to set up AdMob by adding the following metadata in your
`AndroidManifest.xml` file:

 <!-- Sample AdMob app ID: ca-app-pub-3940256099942544~3347511713 -->

```
<meta-data
android:name="com.google.android.gms.ads.APPLICATION_ID"
android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"/>
```

### IOS:

In the iOS project, you need to set up AdMob by adding the following metadata in your
Runner/Info.plist file:

```
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-################~##########</string>
```

- Command to run the app:
```
fvm flutter run --dart-define=AD_UNIT_ID_ANDROID=ca-app-pub-3940256099942544~3347511713
```
