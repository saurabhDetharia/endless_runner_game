import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  /// To get screen size for current context.
  Size get screenSize => MediaQuery.of(this).size;

  /// To get the text theme set for application level.
  TextTheme get textTheme => Theme.of(this).textTheme;
}
