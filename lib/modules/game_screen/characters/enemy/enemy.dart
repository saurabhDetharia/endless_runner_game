import 'package:endless_runner/models/enemy.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Enemy extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef<PixelRunnerGame> {
  final EnemyModel enemy;
  final GameScreenStore gameStore;

  Enemy({required this.enemy, required this.gameStore}) {
    /// Create enemy movement animation.
    animation = SpriteAnimation.fromFrameData(
      enemy.image,
      SpriteAnimationData.sequenced(
        amount: enemy.frames,
        stepTime: enemy.stepTime,
        textureSize: enemy.textureSize,
      ),
    );
  }

  @override
  void onMount() {
    size *= 0.6;

    add(
      RectangleHitbox.relative(
        Vector2.all(0.8),
        parentSize: size,
        position: Vector2(size.x * 0.2, size.y * 0.2) / 2,
      ),
    );
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= enemy.speedX * dt;

    /**
     * If current component's x-point is less
     * than the screen's x-point, remove it
     * from the game world.
      */
    if (position.x < -enemy.textureSize.x) {
      removeFromParent();
      gameStore.updateScore(10);
    }
    super.update(dt);
  }
}
