import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/hud/lives_list.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nes_ui/nes_ui.dart';

class Hud extends StatelessWidget {
  const Hud({required this.game, required this.gameStore, super.key});

  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  static const id = 'ScreenOptions';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Left side options
        Positioned(
          top: 30,
          left: 30,
          child: Row(
            children: [
              // Pause Icon
              NesButton(
                type: NesButtonType.normal,
                onPressed: () {
                  game.overlays
                    ..remove(Hud.id)
                    ..add(PauseOptions.id);

                  // It pauses the game engine
                  game.pauseEngine();
                },
                child: const Icon(FluentIcons.pause_24_filled),
              ),

              const SizedBox(width: 30),

              // Score
              Observer(
                builder: (context) {
                  final score = gameStore.score.toString().padLeft(3, '0');
                  return Stack(
                    children: [
                      Text(
                        'Score:$score',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Colors.black,
                        ),
                      ),
                      Text(
                        'Score:$score',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.instance.text.color,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),

        // Lives indicator
        Positioned(top: 30, right: 30, child: LivesList(gameStore: gameStore)),
      ],
    );
  }
}
