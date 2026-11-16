import 'package:endless_runner/application/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // The runner is designed around a vertical play field.
  Flame.device..fullScreen()..setPortrait();
  runApp(const Game());
}
