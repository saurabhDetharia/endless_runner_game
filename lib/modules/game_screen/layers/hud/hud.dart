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
  Widget build(BuildContext context) => SafeArea(
    minimum: const EdgeInsets.fromLTRB(10, 8, 10, 0),
    child: LayoutBuilder(builder: (context, constraints) {
      final compact = constraints.maxWidth < 360;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PixelButton(
            label: compact ? '' : 'PAUSE',
            icon: FluentIcons.pause_24_filled,
            compact: true,
            onPressed: () {
              game.overlays..remove(Hud.id)..add(PauseOptions.id);
              game.pauseEngine();
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 2),
                child: LivesList(gameStore: gameStore),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Observer(builder: (_) => Container(
            padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 12, vertical: 9),
            decoration: BoxDecoration(
              color: const Color(0xFF17243A),
              border: Border.all(color: const Color(0xFFFFD34E), width: 3),
              boxShadow: const [BoxShadow(color: Color(0xCC07162D), offset: Offset(3, 3), blurRadius: 0)],
            ),
            child: Text(
              '${gameStore.score.toString().padLeft(3, '0')}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFFFFE27A),
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
          )),
        ],
      );
    }),
  );
}
