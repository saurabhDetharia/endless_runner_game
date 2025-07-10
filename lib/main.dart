import 'dart:async';

import 'package:endless_runner/application/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  // To ensure the binding initialised.
  WidgetsFlutterBinding.ensureInitialized();

  // To ensure the Mobile Ads are initialised.
  unawaited(MobileAds.instance.initialize());

  // Sets the app to be full-screen and
  // preferred orientation of the app to landscape only.
  Flame.device
    ..fullScreen()
    ..setLandscape();

  // To run the game
  runApp(const Game());
}
