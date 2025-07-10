// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GameScreenStore on _GameScreenStore, Store {
  late final _$livesAtom =
      Atom(name: '_GameScreenStore.lives', context: context);

  @override
  int get lives {
    _$livesAtom.reportRead();
    return super.lives;
  }

  @override
  set lives(int value) {
    _$livesAtom.reportWrite(value, super.lives, () {
      super.lives = value;
    });
  }

  late final _$scoreAtom =
      Atom(name: '_GameScreenStore.score', context: context);

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  late final _$isMusicOnAtom =
      Atom(name: '_GameScreenStore.isMusicOn', context: context);

  @override
  bool get isMusicOn {
    _$isMusicOnAtom.reportRead();
    return super.isMusicOn;
  }

  @override
  set isMusicOn(bool value) {
    _$isMusicOnAtom.reportWrite(value, super.isMusicOn, () {
      super.isMusicOn = value;
    });
  }

  late final _$isSfxOnAtom =
      Atom(name: '_GameScreenStore.isSfxOn', context: context);

  @override
  bool get isSfxOn {
    _$isSfxOnAtom.reportRead();
    return super.isSfxOn;
  }

  @override
  set isSfxOn(bool value) {
    _$isSfxOnAtom.reportWrite(value, super.isSfxOn, () {
      super.isSfxOn = value;
    });
  }

  late final _$isPlayingMusicAtom =
      Atom(name: '_GameScreenStore.isPlayingMusic', context: context);

  @override
  bool get isPlayingMusic {
    _$isPlayingMusicAtom.reportRead();
    return super.isPlayingMusic;
  }

  @override
  set isPlayingMusic(bool value) {
    _$isPlayingMusicAtom.reportWrite(value, super.isPlayingMusic, () {
      super.isPlayingMusic = value;
    });
  }

  late final _$_GameScreenStoreActionController =
      ActionController(name: '_GameScreenStore', context: context);

  @override
  void collision() {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.collision');
    try {
      return super.collision();
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onHealthConsumption() {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.onHealthConsumption');
    try {
      return super.onHealthConsumption();
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateScore(int newScore) {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.updateScore');
    try {
      return super.updateScore(newScore);
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.reset');
    try {
      return super.reset();
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSfx() {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.updateSfx');
    try {
      return super.updateSfx();
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void playPauseMusic(bool isPlaying) {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.playPauseMusic');
    try {
      return super.playPauseMusic(isPlaying);
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMusic() {
    final _$actionInfo = _$_GameScreenStoreActionController.startAction(
        name: '_GameScreenStore.updateMusic');
    try {
      return super.updateMusic();
    } finally {
      _$_GameScreenStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
lives: ${lives},
score: ${score},
isMusicOn: ${isMusicOn},
isSfxOn: ${isSfxOn},
isPlayingMusic: ${isPlayingMusic}
    ''';
  }
}
