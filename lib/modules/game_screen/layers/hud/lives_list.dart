import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LivesList extends StatelessWidget {
  const LivesList({required this.gameStore, super.key});
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) => Observer(builder: (_) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(color: const Color(0xEFFFFFFF), border: Border.all(color: const Color(0xFF17171D), width: 3), boxShadow: const [BoxShadow(color: Color(0xFF17171D), offset: Offset(4, 4), blurRadius: 0)]),
    child: Row(mainAxisSize: MainAxisSize.min, children: List.generate(5, (index) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Icon(FluentIcons.heart_24_filled, size: 20, color: index < gameStore.lives ? const Color(0xFFE53950) : const Color(0xFFB7B7B7)),
    ))),
  ));
}
