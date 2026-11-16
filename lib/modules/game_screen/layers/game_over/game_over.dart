import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({required this.game, required this.gameStore, super.key});
  static const id = 'GameOver';
  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) => PixelOverlay(child: PixelPanel(maxWidth: 440, child: Column(mainAxisSize: MainAxisSize.min, children: [
    const PixelHeading('GAME OVER', color: Color(0xFFB42332)),
    const SizedBox(height: 14),
    Text('RUN COMPLETE', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF52627A), letterSpacing: 2, fontWeight: FontWeight.w800)),
    const SizedBox(height: 24),
    Container(width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 18), decoration: BoxDecoration(color: const Color(0xFFE8F0FF), border: Border.all(color: const Color(0xFF17171D), width: 3)), child: Column(children: [
      Text('YOUR SCORE', style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF52627A), letterSpacing: 2, fontWeight: FontWeight.w900)),
      const SizedBox(height: 6),
      Text(gameStore.score.toString().padLeft(3, '0'), style: Theme.of(context).textTheme.displaySmall?.copyWith(color: const Color(0xFF0754B8), fontWeight: FontWeight.w900)),
    ])),
    const SizedBox(height: 28),
    Wrap(alignment: WrapAlignment.center, spacing: 14, runSpacing: 14, children: [
      PixelButton(label: 'HOME', icon: FluentIcons.home_24_filled, width: 145, onPressed: () { gameStore.reset(); game.reset(); game.overlays..remove(GameOver.id)..add(MainMenu.id); game.resumeEngine(); }),
      PixelButton(label: 'RETRY', icon: FluentIcons.arrow_counterclockwise_24_filled, width: 145, onPressed: () { gameStore.reset(); game.overlays..remove(GameOver.id)..add(Hud.id); game.resumeEngine(); game.reset(); game.startGame(); }),
    ]),
  ])));
}
