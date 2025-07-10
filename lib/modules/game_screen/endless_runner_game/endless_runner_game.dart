import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:endless_runner/helper/audio_helper.dart';
import 'package:endless_runner/models/player.dart';
import 'package:endless_runner/modules/game_screen/characters/characters.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/app_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';

class PixelRunnerGame extends FlameGame
    with TapDetector, HasCollisionDetection {
  PixelRunnerGame({required this.gameStore, super.camera});

  // Sky backgrounds
  final skyBgs = [
    AppAssets.skyBg,
    AppAssets.skyNightBg,
    AppAssets.skyNoonBg,
    AppAssets.skyOrangeBg,
  ];

  // Platform images
  final platforms = [
    AppAssets.dayPlatform,
    AppAssets.bricksPlatform,
    AppAssets.rocksPlatform,
  ];

  // Middle layer images
  final middleLayers = [AppAssets.trees, AppAssets.foreground];

  // Player images
  final players = [
    AppAssets.boar,
    AppAssets.bee,
    AppAssets.snail,
    AppAssets.player,
  ];

  // Other asset images
  final otherAssets = [AppAssets.health, AppAssets.coin];

  Vector2 get virtualSize => camera.viewport.virtualSize;

  double _backgroundSpeed = 100;

  /// Characters involved in the game.
  late EnemyManager _enemyManager;
  late HealthManager _healthManager;
  late Player _player;

  /// To control game and re-render UI components
  /// like, lives, score, background music and SFXs.
  final GameScreenStore gameStore;

  /// SFXs and musics used in the game.
  final _bgMusic = AudioHelper();
  final _jumpSfx = AudioHelper();
  final _collisionSfx = AudioHelper();
  final _healthSfx = AudioHelper();
  final _coinSfx = AudioHelper();

  // Used to load items randomly.
  final _random = Random();

  @override
  FutureOr<void> onLoad() async {
    // Load required image assets during the game.
    await images.loadAll([
      ...skyBgs,
      ...platforms,
      ...middleLayers,
      ...players,
      ...otherAssets,
    ]);

    // It loads the required music/SFX.
    await _loadSFX();

    // Plays background music.
    if (gameStore.isMusicOn) {
      _bgMusic.play();
    }

    // The game coordinates of a point that is to be positioned at the center
    // of the viewport.
    camera.viewfinder.position = camera.viewport.virtualSize * 0.5;

    // Add the components, which are rendered statically behind the world.
    // Like the parallax component which should be static when
    // the camera moves around.
    camera.backdrop.add(BackgroundScreen(speed: _backgroundSpeed));
  }

  @override
  void onTapDown(TapDownInfo info) {
    _player.jump(_jumpSfx);
    super.onTapDown(info);
  }

  /// This will be used to load the SFX audio files.
  Future<void> _loadSFX() async {
    // Background Music
    await Future.wait([
      _bgMusic.init(AppAssets.bgMusic, shouldLoop: true),

      // Music to play while jump action
      _jumpSfx.init(AppAssets.jumpSfx),

      // Music to play while collision
      _collisionSfx.init(AppAssets.hurtSfx),

      // Music to play while life span extended
      _healthSfx.init(AppAssets.healthSfx),

      // Music to play while coin collected
      _coinSfx.init(AppAssets.coinSfx),
    ]);
  }

  /// This will be called when `Start` button
  /// pressed to start the game.
  Future<void> startGame() async {
    // This sets the speed of background images for the parallax.
    _backgroundSpeed = 100;

    final playerData = PlayerData();

    // This will be used to load player.
    _player = Player(
      image: images.fromCache(AppAssets.player),
      playerData: playerData,
      gameStore: gameStore,
      hitSfx: _collisionSfx,
      healthSfx: _healthSfx,
      coinSfx: _coinSfx,
    );

    _healthManager = HealthManager(
      image: await images.load(AppAssets.health),
      gameScreenStore: gameStore,
      healthConsumptionSfx: _collisionSfx,
    );

    // This will be used to load enemies randomly.
    _enemyManager = EnemyManager(gameStore);

    // Adds enemy and player to the [World] that the [camera] is rendering.
    world
      ..add(_enemyManager)
      ..add(_player)
      ..add(_healthManager)
      ..add(
        SpawnComponent(
          factory: (index) {
            return Coin(
              mPosition: Vector2(
                size.x + _random.nextDouble(),
                size.y - (_random.nextInt(100) + 50),
              ),
              gameScreenStore: gameStore,
              coinSfx: _coinSfx,
            );
          },
          period: _random.nextInt(10).toDouble() + 4,
          area: Rectangle.fromLTWH(0, 0, size.x, -24),
        ),
      );
  }

  /// This will be used to reset game.
  void reset() {
    // Remove all characters.
    _removeCharacters();
    // Resets score and lives.
    gameStore.reset();
  }

  /// This will be used to remove all characters.
  void _removeCharacters() {
    // Removes player component.
    _player.removeFromParent();

    // Removes health component first and then manager component.
    _healthManager.removeHealth();
    _healthManager.removeFromParent();

    // Removes enemy component first and then manager component.
    _enemyManager.removeAllEnemies();
    _enemyManager.removeFromParent();
  }

  /// This will be used to update the background music state.
  void updateBackgroundMusicState(bool isPlaying) {
    isPlaying ? _bgMusic.pause() : _bgMusic.play();
    gameStore.playPauseMusic(!isPlaying);
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Play the music tracks.
        if (gameStore.isMusicOn /*&& !gameStore.isPlayingMusic*/ ) {
          _bgMusic.play();
          gameStore.playPauseMusic(true);
        }

        /**
         * Resumes game engine if the game over
         * overlay is not appearing.
         */

        if (!overlays.isActive(PauseOptions.id)) {
          resumeEngine();
        }
        break;

      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        // Pause the music tracks.
        _bgMusic.pause();
        gameStore.playPauseMusic(false);
        _jumpSfx.pause();
        _collisionSfx.pause();

        /**
         * If the game is running, [Hud] overlay
         * must be visible, So, remove it and
         * show [PauseOptions] overlay.
         */
        if (overlays.isActive(Hud.id)) {
          pauseEngine();
          overlays
            ..remove(Hud.id)
            ..add(PauseOptions.id);
        }
        break;
    }
    super.lifecycleStateChange(state);
  }
}
