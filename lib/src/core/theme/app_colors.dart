import 'package:flutter/material.dart';

class AppColors {
  static AppColors? _instance;

  AppColors._();

  static AppColors get instance {
    _instance ??= AppColors._();

    return _instance!;
  }

  Color get primary => const Color(0xFFFF9000);
  Color get black => const Color(0xFF000000);
  Color get blackMedium => const Color(0xFF28262E);
  Color get white => const Color(0xFFFF9000);
  Color get grey => const Color(0xFF999591);
  Color get greyDark => const Color(0xFF666360);
  Color get shape => const Color(0xFF3E3B47);
  Color get background => const Color(0xFF312E38);
  Color get inputs => const Color(0xFF232129);
  Color get green => const Color(0xFF04D361);
  Color get red => const Color(0xFFF84949);
}
