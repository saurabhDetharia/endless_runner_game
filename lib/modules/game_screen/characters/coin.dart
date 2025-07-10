import 'package:endless_runner/helper/audio_helper.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/app_assets.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Coin extends SpriteAnimationComponent
    with HasGameRef<PixelRunnerGame>, CollisionCallbacks {
  Coin({this.mPosition, required this.gameScreenStore, required this.coinSfx})
    : super(size: Vector2.all(24), anchor: Anchor.bottomLeft);

  final Vector2? mPosition;
  final GameScreenStore gameScreenStore;
  final AudioHelper coinSfx;

  @override
  Future<dynamic> onLoad() async {
    await super.onLoad();

    // It sets components
    if (mPosition != null) {
      position = mPosition!;
    }

    // Defines coin animation.
    animation = await game.loadSpriteAnimation(
      AppAssets.coin,
      SpriteAnimationData.sequenced(
        amount: 6,
        stepTime: 0.1,
        textureSize: Vector2.all(24),
      ),
    );

    add(RectangleHitbox(collisionType: CollisionType.active));
  }

  @override
  void onMount() {
    // Removes view if already mounted
    if (isMounted) {
      removeFromParent();
    }
    super.onMount();
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x -= 100 * dt;

    // If the position crosses minimum edge, remove component.
    if (position.x < -size.x) {
      removeFromParent();
    }
  }
}
