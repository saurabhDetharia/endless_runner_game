import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/hud/lives_list.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Hud extends StatelessWidget {
  const Hud({required this.game, required this.gameStore, super.key});
  final PixelRunnerGame game;
  final GameScreenStore gameStore;
  static const id = 'ScreenOptions';

  @override
  Widget build(BuildContext context) => SafeArea(minimum: const EdgeInsets.all(12), child: Stack(children: [
    Positioned(top: 4, left: 4, child: PixelButton(label: 'PAUSE', icon: FluentIcons.pause_24_filled, compact: true, onPressed: () { game.overlays..remove(Hud.id)..add(PauseOptions.id); game.pauseEngine(); })),
    Positioned(top: 4, right: 4, child: Observer(builder: (_) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xEFFFFFFF), border: Border.all(color: const Color(0xFF17171D), width: 3), boxShadow: const [BoxShadow(color: Color(0xFF17171D), offset: Offset(4, 4), blurRadius: 0)]),
      child: Text('SCORE  ${gameStore.score.toString().padLeft(3, '0')}', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: const Color(0xFF11131A), fontWeight: FontWeight.w900, letterSpacing: 1)),
    ))),
    Positioned(left: 8, bottom: 8, child: LivesList(gameStore: gameStore)),
  ]));
}
