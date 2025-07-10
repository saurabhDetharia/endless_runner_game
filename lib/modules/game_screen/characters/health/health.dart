import 'dart:ui';

import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Health extends SpriteComponent
    with CollisionCallbacks, HasGameRef<PixelRunnerGame> {
  Health(this.image, this.gameScreenStore) {
    sprite = Sprite(image);
  }

  final Image image;
  final GameScreenStore gameScreenStore;

  @override
  void onMount() {
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
    position.x -= 80 * dt;

    if (position.x < -size.x) {
      removeFromParent();
    }

    super.update(dt);
  }
}
