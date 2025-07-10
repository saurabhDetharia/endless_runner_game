import 'package:mobx/mobx.dart';

part 'game_screen_store.g.dart';

class GameScreenStore = _GameScreenStore with _$GameScreenStore;

abstract class _GameScreenStore with Store {
  @observable
  int lives = 5;

  @observable
  int score = 0;

  @observable
  bool isMusicOn = true;

  @observable
  bool isSfxOn = true;

  @observable
  bool isPlayingMusic = false;

  @action
  void collision() {
    lives -= 1;
    if (score > 0) {
      score -= 2;
    }
  }

  @action
  void onHealthConsumption() {
    lives += 1;
  }

  @action
  updateScore(int newScore) {
    score += newScore;
  }

  @action
  void reset() {
    lives = 5;
    score = 0;
  }

  @action
  void updateSfx() {
    isSfxOn = !isSfxOn;
  }

  @action
  void playPauseMusic(bool isPlaying) {
    isPlayingMusic = isPlaying;
  }

  @action
  void updateMusic() {
    isMusicOn = !isMusicOn;
  }
}
