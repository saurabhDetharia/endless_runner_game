import 'dart:math';

import 'package:endless_runner/models/enemy.dart';
import 'package:endless_runner/modules/game_screen/characters/characters.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/app_assets.dart';
import 'package:flame/components.dart';

class EnemyManager extends Component with HasGameRef<PixelRunnerGame> {
  EnemyManager(this.gameStore) {
    // This will spawn one enemy randomly.
    _timer.onTick = spawnRandomEnemy;
  }

  // List of enemies.
  final _enemies = <EnemyModel>[];

  // To get random number to load enemy randomly.
  final _random = Random();

  // To add character automatically at defined interval.
  final _timer = Timer(2.5, repeat: true);

  final GameScreenStore gameStore;

  /// This will be used to spawn an enemy randomly
  /// once the timer is ticked.
  spawnRandomEnemy() {
    // Get one random number within [_data]'s length range.
    final randomIndex = _random.nextInt(_enemies.length);

    // Get the enemy character details at generated index.
    final enemyData = _enemies[randomIndex];

    // Create component instance.
    final enemy = Enemy(enemy: enemyData, gameStore: gameStore);

    // This point is considered to be
    // the logical "center" of the component.
    enemy.anchor = Anchor.bottomLeft;

    // The position of this component's anchor on the screen.
    enemy.position = Vector2(
      game.virtualSize.x + _random.nextDouble() + 32,
      game.virtualSize.y - 28,
    );

    if (enemyData.canFly) {
      final newHeight = _random.nextDouble() * 4 * enemyData.textureSize.y;
      enemy.position.y -= newHeight;
    }

    enemy.size = enemyData.textureSize;
    game.world.add(enemy);
  }

  @override
  void onMount() {
    if (isMounted) {
      removeFromParent();
    }

    _enemies.addAll([
      EnemyModel(
        image: game.images.fromCache(AppAssets.boar),
        frames: 6,
        stepTime: 0.1,
        textureSize: Vector2(48, 32),
        speedX: 80,
        canFly: false,
      ),
      EnemyModel(
        image: game.images.fromCache(AppAssets.bee),
        frames: 4,
        stepTime: 0.1,
        textureSize: Vector2.all(40),
        speedX: 80,
        canFly: true,
      ),
      EnemyModel(
        image: game.images.fromCache(AppAssets.snail),
        frames: 8,
        stepTime: 0.1,
        textureSize: Vector2(48, 32),
        speedX: 80,
        canFly: false,
      ),
    ]);
    spawnRandomEnemy();
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  /// This will remove all enemies from parent.
  void removeAllEnemies() {
    final enemies = game.world.children.whereType<Enemy>();
    for (final enemy in enemies) {
      enemy.removeFromParent();
    }
  }
}
