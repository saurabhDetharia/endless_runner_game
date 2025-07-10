import 'dart:ui';

import 'package:endless_runner/helper/audio_helper.dart';
import 'package:endless_runner/models/player.dart';
import 'package:endless_runner/modules/game_screen/characters/characters.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/game_over/game_over.dart';
import 'package:endless_runner/modules/game_screen/layers/hud/hud.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// Different states of the Player.
enum PlayerStates { idle, run, jump, hit, attack }

class Player extends SpriteAnimationGroupComponent<PlayerStates>
    with CollisionCallbacks, HasGameReference<PixelRunnerGame> {
  /// Below defines the different animation states.
  static final _animationStates = {
    PlayerStates.idle: SpriteAnimationData.sequenced(
      amount: 4,
      stepTime: 0.1,
      textureSize: Vector2.all(45),
    ),
    PlayerStates.run: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.1,
      textureSize: Vector2.all(45),
      texturePosition: Vector2(
        // First 4 positions are idle animation,
        // from 5th position run animation will start.
        (4) * 45,
        0,
      ),
    ),
    PlayerStates.jump: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.9,
      textureSize: Vector2.all(45),
      texturePosition: Vector2(
        // First 4 textures are idle animations,
        // 7 textures for running animations.
        // from 11th position jump animation will start.
        (4 + 7) * 45,
        0,
      ),
    ),
    PlayerStates.hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2.all(45),
      texturePosition: Vector2(
        // First 4 textures are idle animations,
        // 7 textures for running animations.
        // Next 3 textures for jumping animations,
        // from 14th position hit animation will start.
        (4 + 7 + 3) * 45,
        0,
      ),
    ),
    PlayerStates.attack: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.1,
      textureSize: Vector2.all(45),
      texturePosition: Vector2(
        // First 4 textures are idle animations,
        // 7 textures for running animations.
        // Next 3 textures for jumping animations,
        // and next 3 textures for hitting animations,
        // from 17th position attack animation will start.
        (4 + 7 + 3 + 3) * 45,
        0,
      ),
    ),
  };

  /// The maximum y position to show the jump
  double yMax = 0;

  /// The maximum speed at Y-Axis.
  double speedY = 0;

  /// Indicates if player hits any enemy,
  /// it will be used to show animation.
  bool _isHit = false;

  /// Below is used to show the hit animation single time.
  final Timer _hitTimer = Timer(1);

  static const double gravity = 800;

  /// Indicates the frame is at highest position.
  bool get isOnGround => (y >= yMax);

  /// To create Player.
  final PlayerData playerData;

  /// To handle different SFXs.
  final AudioHelper hitSfx;
  final AudioHelper coinSfx;
  final AudioHelper healthSfx;

  final GameScreenStore gameStore;

  Player({
    required Image image,
    required this.playerData,
    required this.hitSfx,
    required this.coinSfx,
    required this.healthSfx,
    required this.gameStore,
  }) : super.fromFrameData(image, _animationStates);

  @override
  void onMount() {
    // It reset all the params.
    _reset();

    // It adds player frame at defined position.
    add(
      RectangleHitbox.relative(
        Vector2(0.5, 0.7),
        parentSize: size,
        position: Vector2(size.x * 0.5, size.y * 0.3) / 2,
      ),
    );

    // It sets initial y-axis position.
    yMax = y;

    // When the hit timer is completed,
    // it resets flags and animation states.
    _hitTimer.onTick = () {
      current = PlayerStates.run;
      _isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    /**
     * If the user is not on the ground, based on the
     * gravity speed and Y-axis position will be updated.
     */
    speedY += (gravity * dt / 1.8);
    y += speedY * dt;

    /**
     * If the user is on the ground, the Y-Axis will be zero,
     * speed will be zero. The current state will be running.
     * This will also help to reset the jump positions.
     */
    if (isOnGround) {
      y = yMax;
      speedY = 0;
      if (current != PlayerStates.hit && current != PlayerStates.run) {
        current = PlayerStates.run;
      }
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    /**
     * If the other component is `Enemy`, it will trigger
     * _hit function, if it is not triggered already.
     */
    if (other is Enemy && !_isHit) {
      // This updates the user animation state.
      current = PlayerStates.hit;

      // Removes current enemy from the screen.
      other.removeFromParent();

      // This will be used for animation and handle score.
      _hit();
    } else if (other is Health) {
      /**
       * If the other component is `Health`, life will
       * be increased and health component will be
       * removed from the game.
       */
      // If the SFXs are on, play the life-span music.
      if (gameStore.isSfxOn) {
        healthSfx.play();
      }

      // Due to health kit, live will be increased.
      gameStore.onHealthConsumption();

      // As the health is consumed, remove it from the view.
      other.removeFromParent();
    }
    if (other is Coin) {
      /**
       * If the other component is `Coin`, score will
       * be increased by 10 and coin component will be
       * removed from the game.
       */
      // If the SFXs are on, play the life-span music.
      if (gameStore.isSfxOn) {
        coinSfx.play();
      }

      // Due to health kit, live will be increased.
      gameStore.updateScore(10);

      // As the health is consumed, remove it from the view.
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  /// This will be used to reset all the
  ///  parameters related to player.
  void _reset() {
    // Removes frame from the parent.
    if (isMounted) {
      removeFromParent();
    }
    // [anchor] describes a point within the rectangle of size [size]
    // and sets position to bottom left side.
    anchor = Anchor.bottomLeft;

    // This sets the exact position of the frame,
    // 32 pixels from left side and 12 pixels above
    // from the maximum value of y.
    position = Vector2(45, game.virtualSize.y - 28);

    // Character size - 45x45 pixels
    size = Vector2.all(45);

    // Sets current player states as `Running`.
    current = PlayerStates.run;

    // If the user had hit enemy, reset to false.
    _isHit = false;

    // Current speed will be zero as the beginning.
    speedY = 0;
  }

  /// This will be used when the user taps screen,
  /// It will show jump states.
  void jump(AudioHelper jumpSfx) {
    // It makes sure that jump can occur only,
    // wile the user is on the ground.
    if (isOnGround) {
      // Update the user animation state.
      current = PlayerStates.jump;
      // Decrease the y-Axis position to show jump
      speedY -= 300;
      // Plays SFX for Jump.
      if (gameStore.isSfxOn) {
        jumpSfx.play();
      }
    }
  }

  /// This will be called when the collision occurs.
  void _hit() {
    // To prevent multiple callbacks.
    _isHit = true;

    // To play the hit/collision SFX.
    if (gameStore.isSfxOn) {
      hitSfx.play();
    }

    // Update life count.
    gameStore.collision();

    // To auto stop hit animation states.
    _hitTimer.start();

    // If user lost all lives, game will over
    if (gameStore.lives == 0) {
      // Pauses game engine.
      game.pauseEngine();

      // Remove game score and lives layer
      // and show game over layer.
      game.overlays
        ..remove(Hud.id)
        ..add(GameOver.id);
    }
  }
}
