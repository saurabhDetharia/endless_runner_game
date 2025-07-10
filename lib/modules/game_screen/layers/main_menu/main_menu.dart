import 'dart:ui';

import 'package:endless_runner/extension/context_extension.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({required this.game, super.key});

  static const id = 'MainMenu';
  final PixelRunnerGame game;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.instance.backgroundSettings.color,
          ),
          child: Stack(
            children: [
              // Settings Icon
              Positioned(
                top: 30,
                left: 30,
                child: NesButton(
                  type: NesButtonType.normal,
                  onPressed: () {
                    game.overlays.add(Settings.id);
                  },
                  child: const Icon(FluentIcons.settings_24_filled),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// Title
                      Text(
                        AppStrings.instance.appName,
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: AppColors.instance.text.color,
                          shadows: [
                            const BoxShadow(
                              color: Colors.black,
                              blurRadius: 20,
                            ),
                          ],
                        ),
                      ),

                      /// Start button
                      NesButton.text(
                        type: NesButtonType.normal,
                        onPressed: () async {
                          game.startGame();
                          game.overlays
                            ..remove(MainMenu.id)
                            ..add(Hud.id);
                        },
                        text: AppStrings.instance.startButton,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
