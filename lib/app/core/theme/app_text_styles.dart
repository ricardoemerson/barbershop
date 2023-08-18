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
  static final textBody = textRegular.copyWith(fontSize: 16);
  static final textButton = textMedium.copyWith(fontSize: 16);
  static final textButtonLabel = textBold.copyWith(fontSize: 16);
}
