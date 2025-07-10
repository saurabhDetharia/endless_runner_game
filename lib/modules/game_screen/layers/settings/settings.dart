import 'dart:ui';

import 'package:endless_runner/extension/extensions.dart';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nes_ui/nes_ui.dart';

class Settings extends StatelessWidget {
  const Settings({required this.game, required this.gameStore, super.key});

  static const id = 'Settings';

  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: ColoredBox(
          color: AppColors.instance.backgroundSettings.color,
          child: Align(
            alignment: Alignment.center,
            child: NesContainer(
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  /// Title
                  Text(
                    AppStrings.instance.settings,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: AppColors.instance.seed.color,
                    ),
                  ),

                  const SizedBox(height: 60),

                  /// SFX options
                  Row(
                    children: [
                      // Music icon
                      Observer(
                        builder: (context) {
                          return NesButton(
                            type: NesButtonType.normal,
                            child: Icon(
                              gameStore.isMusicOn
                                  ? FluentIcons.music_note_2_24_filled
                                  : FluentIcons.music_note_off_2_24_filled,
                            ),
                            onPressed: () {
                              // This will be used to play/pause background music.
                              game.updateBackgroundMusicState(
                                gameStore.isMusicOn,
                              );

                              // This will be used to update icons.
                              gameStore.updateMusic();
                            },
                          );
                        },
                      ),

                      const SizedBox(width: 20),

                      // Sounds icon
                      Observer(
                        builder: (context) {
                          return NesButton(
                            type: NesButtonType.normal,
                            child: Icon(
                              gameStore.isSfxOn
                                  ? FluentIcons.speaker_2_48_filled
                                  : FluentIcons.speaker_off_24_filled,
                            ),
                            onPressed: () {
                              gameStore.updateSfx();
                            },
                          );
                        },
                      ),

                      const SizedBox(width: 20),

                      // Back icon
                      NesButton(
                        type: NesButtonType.normal,
                        child: const Icon(FluentIcons.arrow_left_24_filled),
                        onPressed: () {
                          // Removes current layer and shows main menu.
                          game.overlays.remove(Settings.id);
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
