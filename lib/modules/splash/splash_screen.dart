import 'dart:async';

import 'package:endless_runner/extension/extensions.dart';
import 'package:endless_runner/modules/game_screen/game_screen.dart';
import 'package:endless_runner/values/values.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// To auto redirect to next screen
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 1), () {
      context.pushReplace(const GameScreen());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.instance.splashScreenBg.color,
      body: Center(
        child: Text(
          AppStrings.instance.organisationName,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.instance.seed.color),
        ),
      ),
    );
  }
}
