extension NumberToTextExtension on int {
  /// This converts [int] value to string with given
  /// length as [digits]. I
  String fixedDigits(int digits) {
    final str = toString();
    var formattedStr = str;

    while (str.length < digits) {
      formattedStr = '0$formattedStr';
    }
    return formattedStr;
  }
}
