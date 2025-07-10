class AppStrings {
  const AppStrings._();

  static AppStrings get instance => const AppStrings._();

  factory AppStrings() {
    return instance;
  }

  String get organisationName => 'Simform Solutions';
  String get appName => 'Pixel Runner';
  String get highScore => 'High Score';
  String get startButton => 'Start';
  String get options => 'Paused';
  String get settings => 'Settings';
  String get gameOver => 'Game Over';
}
