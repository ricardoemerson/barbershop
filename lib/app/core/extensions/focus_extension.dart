import 'package:flutter/material.dart';

extension FocusExtension on BuildContext {
  void requestFocus() => FocusScope.of(this).requestFocus();
  void unfocus() => FocusScope.of(this).unfocus();
}
