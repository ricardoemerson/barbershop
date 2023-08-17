import 'package:flutter/material.dart';

import 'theme.dart';

sealed class AppTheme {
  static final defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(color: AppColors.greyDark),
  );

  static final themeData = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    fontFamily: AppTextStyles.fontFamily,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.white),
      bodyMedium: TextStyle(color: AppColors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.primary),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        textStyle: AppTextStyles.textButtonLabel,
        minimumSize: const Size.fromHeight(56),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.textButton,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.inputs,
      filled: true,
      // isDense: true,
      labelStyle: AppTextStyles.textMedium.copyWith(
        color: AppColors.white,
        fontSize: 16,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: AppTextStyles.textRegular.copyWith(fontSize: 16, color: AppColors.greyDark),
      // contentPadding: const EdgeInsets.only(top: 15, left: 17, right: 17),
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.error),
      ),
      errorStyle: AppTextStyles.textRegular.copyWith(
        color: AppColors.error,
      ),
    ),
  );
}
