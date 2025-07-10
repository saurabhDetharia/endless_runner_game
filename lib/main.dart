import 'package:endless_runner/application/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // To ensure the binding initialised.
  WidgetsFlutterBinding.ensureInitialized();

  // Sets the app to be full-screen and
  // preferred orientation of the app to landscape only.
  Flame.device
    ..fullScreen()
    ..setLandscape();

  // To run the game
  runApp(const Game());
}
