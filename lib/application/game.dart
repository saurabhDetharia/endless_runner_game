import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:endless_runner/modules/splash/splash_screen.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Runner',
      theme: flutterNesTheme(),
      home: const SplashScreen(),
    );
  }
}
