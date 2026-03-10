import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static const double fontSize28 = 28.0;
  static const double fontSize22 = 22.0;
  static const double fontSize18 = 18.0;
  static const double fontSize14 = 14.0;
  static const double fontSize12 = 12.0;

  static const double fontWeightLight = FontWeight.w300;
  static const double fontWeightRegular = FontWeight.w400;
  static const double fontWeightMedium = FontWeight.w500;
  static const double fontWeightSemiBold = FontWeight.w600;
  static const double fontWeightBold = FontWeight.w700;

  static const double lineHeightTight = 1.2;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;

  static String get fontFamily => GoogleFonts.inter().fontFamily ?? 'Inter';

  static TextStyle get displayLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize28,
        fontWeight: fontWeightBold,
        height: lineHeightTight,
      );

  static TextStyle get displayMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize22,
        fontWeight: fontWeightSemiBold,
        height: lineHeightTight,
      );

  static TextStyle get headline => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize18,
        fontWeight: fontWeightSemiBold,
        height: lineHeightNormal,
      );

  static TextStyle get bodyLarge => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize18,
        fontWeight: fontWeightRegular,
        height: lineHeightNormal,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize14,
        fontWeight: fontWeightRegular,
        height: lineHeightNormal,
      );

  static TextStyle get bodySmall => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize12,
        fontWeight: fontWeightRegular,
        height: lineHeightRelaxed,
      );

  static TextStyle get caption => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize12,
        fontWeight: fontWeightMedium,
        height: lineHeightRelaxed,
      );

  static TextStyle get button => TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize14,
        fontWeight: fontWeightSemiBold,
        height: lineHeightNormal,
        letterSpacing: 0.5,
      );
}
