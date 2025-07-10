import 'dart:async';
import 'dart:math';

import 'package:endless_runner/values/app_assets.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundScreen extends ParallaxComponent {
  final double speed;

  BackgroundScreen({required this.speed});

  @override
  FutureOr<void> onLoad() async {
    // Create layers list
    final layers = [
      ParallaxImageData(AppAssets.skyBg),
      ParallaxImageData(AppAssets.foreground),
      ParallaxImageData(AppAssets.trees),
      ParallaxImageData(AppAssets.bricksPlatform),
    ];

    /**
     * Calculate base velocity on X-Axis.
     * Y-Axis for all the background components,
     * will remain the same, so keeping it 0.
     */
    final baseVelocity = Vector2(speed / pow(2, layers.length), 0);

    final velocityMultiplierDelta = Vector2(2, 0);

    /**
     * Load all the layers with Parallax effect.
     * [baseVelocity] defines what the base velocity of the
     * layers should be and [velocityMultiplierDelta] defines how the velocity
     * should change the closer the layer is (`velocityMultiplierDelta ^ n`,
     * where `n` is the layer index).
     */
    parallax = await game.loadParallax(
      layers,
      baseVelocity: baseVelocity,
      velocityMultiplierDelta: velocityMultiplierDelta,
      filterQuality: FilterQuality.none,
    );

    return super.onLoad();
  }
}
