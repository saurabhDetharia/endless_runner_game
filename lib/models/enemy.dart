import 'package:flame/extensions.dart';

class EnemyModel {
  final Image image;
  final int frames;
  final double stepTime;
  final Vector2 textureSize;
  final double speedX;
  final bool canFly;

  EnemyModel({
    required this.image,
    required this.frames,
    required this.stepTime,
    required this.textureSize,
    required this.speedX,
    required this.canFly,
  });
}
