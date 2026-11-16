import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LivesList extends StatelessWidget {
  const LivesList({required this.gameStore, super.key});
  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) => Observer(builder: (_) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
    decoration: BoxDecoration(
      color: const Color(0xFF17243A),
      border: Border.all(color: const Color(0xFFFFD34E), width: 2),
      boxShadow: const [BoxShadow(color: Color(0x9907162D), offset: Offset(3, 3), blurRadius: 0)],
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      const Padding(
        padding: EdgeInsets.only(right: 5),
        child: Text('HP', style: TextStyle(color: Color(0xFFFFE27A), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1)),
      ),
      ...List.generate(5, (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1),
        child: Icon(
          FluentIcons.heart_24_filled,
          size: 15,
          color: index < gameStore.lives ? const Color(0xFFFF5368) : const Color(0xFF64748B),
        ),
      )),
    ]),
  ));
}
