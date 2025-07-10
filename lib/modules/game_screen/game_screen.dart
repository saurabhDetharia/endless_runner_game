import 'package:endless_runner/modules/game_screen/layers/layers.dart';
import 'package:endless_runner/modules/game_screen/store/game_screen_store.dart';
import 'package:endless_runner/values/app_colors.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'endless_runner_game/endless_runner_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameScreenStore gameStore;
  late PixelRunnerGame game;

  @override
  void initState() {
    super.initState();
    gameStore = GameScreenStore();
    game = PixelRunnerGame(gameStore: gameStore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget.controlled(
        backgroundBuilder: (_) {
          return Container(
            color: AppColors.instance.background.color,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          );
        },
        overlayBuilderMap: {
          MainMenu.id: (_, game) => MainMenu(game: game as PixelRunnerGame),
          Hud.id: (_, game) =>
              Hud(game: game as PixelRunnerGame, gameStore: gameStore),
          Settings.id: (_, game) =>
              Settings(game: game as PixelRunnerGame, gameStore: gameStore),
          PauseOptions.id: (_, game) =>
              PauseOptions(game: game as PixelRunnerGame, gameStore: gameStore),
          GameOver.id: (_, game) =>
              GameOver(game: game as PixelRunnerGame, gameStore: gameStore),
          AdViewWidget.id: (_, game) =>
              const AdViewWidget(adSize: AdSize.fullBanner),
        },
        initialActiveOverlays: const [MainMenu.id],
        gameFactory: () {
          return game;
        },
      ),
    );
  }
}
