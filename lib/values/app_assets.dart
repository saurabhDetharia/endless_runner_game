class AppAssets {
  const AppAssets._();

  static AppAssets get instance => const AppAssets._();

  factory AppAssets() {
    return instance;
  }

  /// Sky background images --->
  static const skyBg = 'sky_bg.png';
  static const skyNightBg = 'sky_bg_night.png';
  static const skyNoonBg = 'sky_bg_noon.png';
  static const skyOrangeBg = 'sky_bg_orange.png';

  /// <---

  /// Platform images --->
  static const bricksPlatform = 'platform_bricks.png';
  static const dayPlatform = 'platform_day.png';
  static const rocksPlatform = 'platform_rocks.png';

  /// <---

  /// Middle layer images --->
  static const trees = 'trees.png';
  static const foreground = 'foreground.png';

  /// <---

  /// Players images --->
  static const boar = 'boar.png';
  static const bee = 'bee.png';
  static const snail = 'snail.png';
  static const player = 'player.png';

  /// <---

  /// Other asset images --->
  static const coin = 'coin.png';
  static const health = 'health.png';

  /// <---

  /// Music --->
  static const bgMusic = 'sfx/bg_music.wav';
  static const jumpSfx = 'sfx/jump.wav';
  static const hurtSfx = 'sfx/hurt.wav';
  static const coinSfx = 'sfx/coin.wav';
  static const healthSfx = 'sfx/power_up.wav';

  /// <---
}
