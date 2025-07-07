import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';

import '../../theme/app_colors/app_colors.dart';
import '../../theme/theme_engine/theme_engine.dart';
import '../engine/translation_engine.dart';

class AppTextStyles {
  AppTextStyles({
    required TranslationEngine translationEngine,
    required ThemeEngine themeEngine,
    required AppColors appColors,
  }) : _appColors = appColors,
       _themeEngine = themeEngine,
       _translationEngine = translationEngine;

  final TranslationEngine _translationEngine;
  final ThemeEngine _themeEngine;
  final AppColors _appColors;

  /* -------------------------------------------------------------------------- */
  /*                                 TEXT STYLES                                */
  /* -------------------------------------------------------------------------- */

  /* --------------------------------- REGULAR -------------------------------- */
  TextStyle get regular8 => getActiveTextStyle(
    fontSize: 8.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  TextStyle get regular36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w400,
  );

  /* --------------------------------- MEDIUM -------------------------------- */
  TextStyle get medium10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  TextStyle get medium36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w500,
  );

  /* ------------------------------- SEMI-BOLD ------------------------------- */
  TextStyle get semiBold10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold18 => getActiveTextStyle(
    fontSize: 18.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  TextStyle get semiBold36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w600,
  );

  /* ---------------------------------- BOLD --------------------------------- */
  TextStyle get bold10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  TextStyle get bold36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w700,
  );

  /* ----------------------------- EXTRA BOLD ------------------------------ */
  TextStyle get extraBold10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  TextStyle get extraBold36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w800,
  );

  /* ---------------------------------- BLACK -------------------------------- */
  TextStyle get black10 => getActiveTextStyle(
    fontSize: 10.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black12 => getActiveTextStyle(
    fontSize: 12.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black14 => getActiveTextStyle(
    fontSize: 14.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black16 => getActiveTextStyle(
    fontSize: 16.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black20 => getActiveTextStyle(
    fontSize: 20.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black24 => getActiveTextStyle(
    fontSize: 24.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black28 => getActiveTextStyle(
    fontSize: 28.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black32 => getActiveTextStyle(
    fontSize: 32.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  TextStyle get black36 => getActiveTextStyle(
    fontSize: 36.sp,
    color: _getActiveColor,
    fontWeight: FontWeight.w900,
  );

  ///
  /// Get active text style based on the current language
  ///
  TextStyle getActiveTextStyle({
    TextStyle? textStyle,
    Color? color,
    Color? backgroundColor,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    List<Shadow>? shadows,
    List<FontFeature>? fontFeatures,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
  }) {
    return _translationEngine.languageKey == injectedAppKeys.en
        ? GoogleFonts.poppins(
            color: color,
            textStyle: textStyle,
            height: height,
            background: background,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: decoration,
            backgroundColor: backgroundColor,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            fontFeatures: fontFeatures,
            fontStyle: fontStyle,
            foreground: foreground,
            letterSpacing: letterSpacing,
            locale: locale,
            shadows: shadows,
            textBaseline: textBaseline,
            wordSpacing: wordSpacing,
          )
        : GoogleFonts.amiri(
            color: color,
            textStyle: textStyle,
            height: height,
            background: background,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: decoration,
            backgroundColor: backgroundColor,
            decorationColor: decorationColor,
            decorationStyle: decorationStyle,
            decorationThickness: decorationThickness,
            fontFeatures: fontFeatures,
            fontStyle: fontStyle,
            foreground: foreground,
            letterSpacing: letterSpacing,
            locale: locale,
            shadows: shadows,
            textBaseline: textBaseline,
            wordSpacing: wordSpacing,
          );
  }

  ///
  /// Get active color based on the current theme
  ///
  Color get _getActiveColor =>
      _themeEngine.isDark.value ? _appColors.white : _appColors.black;
}
