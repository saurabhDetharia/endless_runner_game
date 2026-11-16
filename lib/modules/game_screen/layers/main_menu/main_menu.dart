import 'dart:ui';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({required this.game, super.key});
  static const id = 'MainMenu';
  final PixelRunnerGame game;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
      child: Stack(children: [
        const Positioned.fill(child: ColoredBox(color: Color(0x33091B32))),
        SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final compact = constraints.maxHeight < 520;
          return Stack(children: [
            Positioned(top: 12, right: 12, child: PixelButton(
              label: 'SETTINGS',
              icon: FluentIcons.settings_24_filled,
              compact: true,
              backgroundColor: const Color(0xFFFFF7D6),
              onPressed: () => game.overlays.add(Settings.id),
            )),
            Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: compact ? 58 : 76),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: compact ? 14 : 24, vertical: compact ? 12 : 18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF17243A),
                    border: Border.all(color: const Color(0xFFFFD34E), width: 4),
                    boxShadow: const [BoxShadow(color: Color(0xCC07162D), offset: Offset(7, 7), blurRadius: 0)],
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    FittedBox(fit: BoxFit.scaleDown, child: Text(
                      AppStrings.instance.appName.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: const Color(0xFFFFD34E),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2.5,
                        shadows: const [Shadow(color: Color(0xFF000000), offset: Offset(3, 4), blurRadius: 0)],
                      ),
                    )),
                    const SizedBox(height: 8),
                    Text('★  RUN  •  JUMP  •  SURVIVE  ★', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white, letterSpacing: 1.5, fontWeight: FontWeight.w800)),
                  ]),
                ),
                SizedBox(height: compact ? 28 : 42),
                PixelButton(
                  label: AppStrings.instance.startButton.toUpperCase(),
                  icon: FluentIcons.play_24_filled,
                  width: 230,
                  backgroundColor: const Color(0xFF8DE7A6),
                  onPressed: () {
                    game.startGame();
                    game.overlays..remove(MainMenu.id)..add(Hud.id);
                  },
                ),
                const SizedBox(height: 14),
                Text('TAP ANYWHERE TO JUMP', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.w800, letterSpacing: 1.4, shadows: const [Shadow(color: Colors.black87, blurRadius: 6)])),
              ]),
            )),
          ]);
        })),
      ]),
    ),
  );
}
