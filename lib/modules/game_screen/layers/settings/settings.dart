import 'package:endless_runner/modules/game_screen/endless_runner_game/endless_runner_game.dart';
import 'package:endless_runner/modules/game_screen/layers/widgets/pixel_ui.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class Settings extends StatelessWidget {
  const Settings({required this.game, required this.gameStore, super.key});
  static const id = 'Settings';
  final PixelRunnerGame game;
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) => PixelOverlay(child: PixelPanel(maxWidth: 460, child: Column(mainAxisSize: MainAxisSize.min, children: [
    const PixelHeading('SETTINGS'),
    const SizedBox(height: 28),
    _SettingRow(icon: FluentIcons.music_note_2_24_filled, label: 'BACKGROUND MUSIC', enabled: () => gameStore.isMusicOn, onPressed: () { game.updateBackgroundMusicState(gameStore.isMusicOn); gameStore.updateMusic(); }),
    const SizedBox(height: 14),
    _SettingRow(icon: FluentIcons.speaker_2_48_filled, label: 'SOUND EFFECTS', enabled: () => gameStore.isSfxOn, onPressed: gameStore.updateSfx),
    const SizedBox(height: 28),
    PixelButton(label: 'BACK', icon: FluentIcons.arrow_left_24_filled, width: 180, onPressed: () => game.overlays.remove(Settings.id)),
  ])));

}

class _SettingRow extends StatelessWidget {
  const _SettingRow({required this.icon, required this.label, required this.enabled, required this.onPressed});
  final IconData icon;
  final String label;
  final bool Function() enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Observer(builder: (_) {
    final isEnabled = enabled();
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFE8F0FF), border: Border.all(color: const Color(0xFF17171D), width: 3)),
      child: Row(children: [
        Icon(icon, size: 26, color: const Color(0xFF17243A)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(color: const Color(0xFF17243A), fontWeight: FontWeight.w900))),
        PixelButton(label: isEnabled ? 'ON' : 'OFF', compact: true, backgroundColor: isEnabled ? const Color(0xFFB9F2C7) : const Color(0xFFFFD5D5), onPressed: onPressed),
      ]),
    );
  });
}
