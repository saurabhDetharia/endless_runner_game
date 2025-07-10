import 'package:endless_runner/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static AppTheme get instance => const AppTheme._();

  factory AppTheme() {
    return instance;
  }

  ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.instance.seed.color,
      surface: AppColors.instance.background.color,
    ),
    textTheme: GoogleFonts.pixelifySansTextTheme().apply(
      fontSizeFactor: 1,
      bodyColor: AppColors.instance.text.color,
      displayColor: AppColors.instance.text.color,
    ),
  );
}
