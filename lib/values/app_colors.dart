import 'package:flame/palette.dart';

class AppColors {
  const AppColors._();

  static AppColors get instance => const AppColors._();

  factory AppColors() {
    return instance;
  }

  /// Seed color
  PaletteEntry get seed => const PaletteEntry(
        Color(0xFF0050bc),
      );

  /// Splash screen background color
  PaletteEntry get splashScreenBg => const PaletteEntry(
        Color(0xFFFFFFFF),
      );

  /// Text color
  PaletteEntry get text => const PaletteEntry(
        Color(0xffe4ebff),
      );

  /// Background color
  PaletteEntry get background => const PaletteEntry(
        Color(0xff93E3E4),
      );

  /// Background color for Game session
  PaletteEntry get backgroundPlaySession => const PaletteEntry(
        Color(0xffa2fff3),
      );

  /// Background color for Settings
  PaletteEntry get backgroundSettings => const PaletteEntry(
        Color(0x402D2D35),
      );
}
