import 'dart:ui';
import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/ad_view/ad_view_widget.dart';
import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/values/values.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({required this.game, super.key});
  static const id = 'MainMenu';
  final PixelRunnerGame game;

  @override
  Widget build(BuildContext context) => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Stack(children: [
        const Positioned.fill(child: ColoredBox(color: Color(0x440B2340))),
        SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          final compact = constraints.maxHeight < 520;
          return Stack(children: [
            Positioned(top: 12, left: 12, child: PixelButton(label: 'SETTINGS', icon: FluentIcons.settings_24_filled, compact: true, onPressed: () => game.overlays.add(Settings.id))),
            Center(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: compact ? 62 : 76),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                FittedBox(fit: BoxFit.scaleDown, child: Text(AppStrings.instance.appName, textAlign: TextAlign.center, style: Theme.of(context).textTheme.displayMedium?.copyWith(color: const Color(0xFFE4EBFF), fontWeight: FontWeight.w900, letterSpacing: 2, shadows: const [Shadow(color: Color(0xCC07162D), offset: Offset(5, 6), blurRadius: 0), Shadow(color: Colors.black54, blurRadius: 18)]))),
                const SizedBox(height: 12),
                Text('RUN  •  JUMP  •  SURVIVE', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white, letterSpacing: 3, fontWeight: FontWeight.w800, shadows: const [Shadow(color: Colors.black87, blurRadius: 8)])),
                SizedBox(height: compact ? 30 : 48),
                PixelButton(label: AppStrings.instance.startButton.toUpperCase(), icon: FluentIcons.play_24_filled, width: 220, onPressed: () async {
                  await showDialog(context: context, builder: (_) => const AdViewWidget(adSize: AdSize.fluid));
                  game.startGame();
                  game.overlays..remove(MainMenu.id)..add(Hud.id);
                }),
              ]),
            )),
          ]);
        })),
      ]),
    ),
  );
}
