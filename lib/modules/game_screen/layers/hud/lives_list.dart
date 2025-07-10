import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LivesList extends StatelessWidget {
  const LivesList({required this.gameStore, super.key});

  final GameScreenStore gameStore;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Observer(
          builder: (context) {
            return Icon(
              FluentIcons.heart_24_filled,
              color: index < gameStore.lives ? Colors.red : Colors.grey,
            );
          },
        );
      }),
    );
  }
}
