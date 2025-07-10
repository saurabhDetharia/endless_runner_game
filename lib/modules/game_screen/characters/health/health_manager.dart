import 'dart:math';
import 'dart:ui';

import 'package:endless_runner/helper/audio_helper.dart';
import 'package:endless_runner/modules/game_screen/characters/health/health.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class HealthManager extends Component
    with CollisionCallbacks, HasGameRef<PixelRunnerGame> {
  HealthManager({
    required this.image,
    required this.gameScreenStore,
    required this.healthConsumptionSfx,
  }) {
    _timer.onTick = spawnHealth;
  }

  final Image image;
  final GameScreenStore gameScreenStore;
  final AudioHelper healthConsumptionSfx;

  final _random = Random();
  // To check if need to load health
  final _timer = Timer(10, repeat: true);

  // To get random number to load health icon randomly.
  Health? health;

  @override
  void onMount() {
    // Removes view if already mounted
    if (isMounted) {
      removeFromParent();
    }

    // Starts timer to frequently check the lives
    _timer.start();

    super.onMount();
  }

  /// Loads health icons
  void spawnHealth() {
    /**
     * If the remaining lives are less than 3,
     * and if the health component is not already showing,
     * then only show health icon to increase the life.
     */
    if (gameScreenStore.lives < 3 && !game.world.children.contains(health)) {
      health = Health(image, gameScreenStore);

      // [anchor] describes a point within the rectangle of size [size]
      // and sets position to bottom left side.
      health!.anchor = Anchor.bottomLeft;

      // The position of this component's anchor on the screen.
      health!.position = Vector2(
        game.virtualSize.x + _random.nextDouble() + 32,
        game.virtualSize.y - _random.nextInt(100) - 60,
      );

      // Health component size - 45x45 pixels
      health!.size = Vector2.all(45);

      // Add health icon to game world.
      game.world.add(health!);
    }
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  /// Used to remove health component from the game world.
  void removeHealth() {
    health?.removeFromParent();
  }
}
