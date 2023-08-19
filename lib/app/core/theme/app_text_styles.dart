import 'package:flutter/material.dart';

sealed class AppTextStyles {
  static const String fontFamily = 'Poppins';

  static const textLight = TextStyle(fontWeight: FontWeight.w300, fontFamily: fontFamily);
  static const textRegular = TextStyle(fontWeight: FontWeight.normal, fontFamily: fontFamily);
  static const textMedium = TextStyle(fontWeight: FontWeight.w500, fontFamily: fontFamily);
  static const textSemiBold = TextStyle(fontWeight: FontWeight.w600, fontFamily: fontFamily);
  static const textBold = TextStyle(fontWeight: FontWeight.bold, fontFamily: fontFamily);
  static const textExtraBold = TextStyle(fontWeight: FontWeight.w800, fontFamily: fontFamily);

  static final textTitle = textExtraBold.copyWith(fontSize: 28);
  static final textBodyExtraSmall = textRegular.copyWith(fontSize: 12);
  static final textSectionTitle = textMedium.copyWith(fontSize: 14);
}
