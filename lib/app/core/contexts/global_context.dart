import 'package:flutter/material.dart';

final class GlobalContext {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static GlobalContext? _instance;

  GlobalContext._();

  static GlobalContext get instance {
    _instance ??= GlobalContext._();

    return _instance!;
  }
}
