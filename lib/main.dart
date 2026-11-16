import 'dart:async';
import 'package:endless_runner/application/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  // The runner is designed around a vertical play field.
  Flame.device..fullScreen()..setPortrait();
  runApp(const Game());
}
