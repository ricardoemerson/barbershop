import 'package:flutter/material.dart';

import 'theme.dart';

class AppTheme {
  AppTheme._();

  static final defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: AppColors.instance.grey),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColors.instance.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.instance.background,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.instance.primary),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.instance.primary,
      primary: AppColors.instance.primary,
      secondary: AppColors.instance.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.instance.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.instance.inputs,
      filled: true,
      // isDense: true,
      hintStyle: AppTextStyles.instance.textRegular
          .copyWith(fontSize: 16, color: AppColors.instance.greyDark),
      contentPadding: const EdgeInsets.only(top: 15, left: 17, right: 17),
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder.copyWith(
        borderSide: BorderSide(color: AppColors.instance.red),
      ),
      labelStyle: AppTextStyles.instance.textMedium.copyWith(
        color: AppColors.instance.white,
      ),
      errorStyle: AppTextStyles.instance.textRegular.copyWith(
        color: AppColors.instance.red,
      ),
    ),
  );
}
