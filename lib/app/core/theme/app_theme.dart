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
    textTheme: TextTheme(
      bodyLarge: AppTextStyles.textRegular.copyWith(color: Colors.white, fontSize: 18),
      bodyMedium: AppTextStyles.textRegular.copyWith(color: Colors.white, fontSize: 16),
      bodySmall: AppTextStyles.textRegular.copyWith(color: Colors.white, fontSize: 14),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.white,
      surfaceTintColor: AppColors.background,
      iconTheme: const IconThemeData(color: AppColors.primary),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTextStyles.textMedium.copyWith(fontSize: 18),
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
        textStyle: AppTextStyles.textSemiBold,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: AppTextStyles.textMedium,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        textStyle: AppTextStyles.textSemiBold,
        side: const BorderSide(color: AppColors.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.primary,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      shape: CircleBorder(),
      backgroundColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.inputs,
      filled: true,
      isDense: true,
      labelStyle: AppTextStyles.textMedium.copyWith(
        color: AppColors.white,
        fontSize: 16,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintStyle: AppTextStyles.textRegular.copyWith(fontSize: 16, color: AppColors.greyDark),
      // contentPadding: const EdgeInsets.only(top: 15, left: 17, right: 17),
      suffixIconColor: AppColors.primary,
      border: defaultInputBorder,
      enabledBorder: defaultInputBorder,
      focusedBorder: defaultInputBorder,
      errorBorder: defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: defaultInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.error),
      ),
      errorStyle: AppTextStyles.textRegular.copyWith(
        color: AppColors.error,
      ),
    ),
  );
}
