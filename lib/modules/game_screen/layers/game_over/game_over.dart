import 'dart:ui';

import 'package:endless_runner/extension/extensions.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class GameOver extends StatelessWidget {
  const GameOver({required this.game, required this.gameStore, super.key});

  static const id = 'GameOver';

  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.instance.backgroundSettings.color,
          ),
          child: Center(
            child: NesContainer(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  /// Title
                  Text(
                    AppStrings.instance.gameOver,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: AppColors.instance.seed.color,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Title
                  Text(
                    'Total Score: ${gameStore.score.toString().padLeft(3, '0')}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.instance.seed.color,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// Options
                  Row(
                    children: [
                      // Play icon
                      NesButton(
                        type: NesButtonType.normal,
                        child: const Icon(FluentIcons.home_24_filled),
                        onPressed: () {
                          // Resets all values.
                          gameStore.reset();

                          // Resets characters.
                          game.reset();

                          // Update overlays
                          game.overlays
                            ..remove(GameOver.id)
                            ..add(MainMenu.id);

                          // Resume game engine
                          game.resumeEngine();
                        },
                      ),

                      const SizedBox(width: 20),

                      // Restart icon
                      NesButton(
                        type: NesButtonType.normal,
                        child: const Icon(
                          FluentIcons.arrow_counterclockwise_24_filled,
                        ),
                        onPressed: () async {
                          // Resets all values.
                          gameStore.reset();

                          // Update overlays
                          game.overlays
                            ..remove(GameOver.id)
                            ..add(Hud.id);

                          // Resume game engine
                          game.resumeEngine();

                          // Remove all characters and reset score.
                          game.reset();

                          // Start again game
                          game.startGame();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
