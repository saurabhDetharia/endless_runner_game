import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PauseOptions extends StatelessWidget {
  const PauseOptions({required this.game, required this.gameStore, super.key});
  static const id = 'PauseOptions';
  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) => PixelOverlay(child: PixelPanel(maxWidth: 460, child: Column(mainAxisSize: MainAxisSize.min, children: [
    const PixelHeading('PAUSED'),
    const SizedBox(height: 28),
    Wrap(alignment: WrapAlignment.center, spacing: 14, runSpacing: 14, children: [
      PixelButton(label: 'HOME', icon: FluentIcons.home_24_filled, width: 150, onPressed: () { game.reset(); game.overlays..remove(PauseOptions.id)..add(MainMenu.id); game.resumeEngine(); }),
      PixelButton(label: 'RESUME', icon: FluentIcons.play_24_filled, width: 150, onPressed: () { game.overlays..remove(PauseOptions.id)..add(Hud.id); game.resumeEngine(); }),
      PixelButton(label: 'RESTART', icon: FluentIcons.arrow_counterclockwise_24_filled, width: 150, onPressed: () { game.overlays..remove(PauseOptions.id)..add(Hud.id); game.resumeEngine(); game.reset(); game.startGame(); }),
    ]),
    const SizedBox(height: 26),
    const Divider(color: Color(0xFFB7C5D8), thickness: 2),
    const SizedBox(height: 12),
    Wrap(alignment: WrapAlignment.center, spacing: 12, children: [
      Observer(builder: (_) => PixelButton(label: gameStore.isMusicOn ? 'MUSIC ON' : 'MUSIC OFF', icon: gameStore.isMusicOn ? FluentIcons.music_note_2_24_filled : FluentIcons.music_note_off_2_24_filled, compact: true, onPressed: () { game.updateBackgroundMusicState(gameStore.isMusicOn); gameStore.updateMusic(); })),
      Observer(builder: (_) => PixelButton(label: gameStore.isSfxOn ? 'SFX ON' : 'SFX OFF', icon: gameStore.isSfxOn ? FluentIcons.speaker_2_48_filled : FluentIcons.speaker_off_24_filled, compact: true, onPressed: gameStore.updateSfx)),
    ]),
  ])));
}
