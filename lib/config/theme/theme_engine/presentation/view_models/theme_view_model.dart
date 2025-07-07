import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/global_utils/global_utils.dart';

class ThemeViewModel extends ChangeNotifier {
  /* -------------------------------------------------------------------------- */
  /*                                  VARIABLES                                 */
  /* -------------------------------------------------------------------------- */

  ValueNotifier<bool> isDark = ValueNotifier(injectedThemeEngine.isDark.value);

  /* -------------------------------------------------------------------------- */
  /*                                   METHODS                                  */
  /* -------------------------------------------------------------------------- */

  ///
  /// Get the theme data (for dark and light theme)
  ///
  ThemeData _getThemeData({
    required Brightness brightness,
    required Color scaffoldBackgroundColor,
  }) => ThemeData(
    // Set the brightness of the theme (light or dark)
    brightness: brightness,
    // Set the scaffold background color
    scaffoldBackgroundColor: scaffoldBackgroundColor,
    // Whether to use the material design 3.0 theme
    useMaterial3: true,
    iconTheme: IconThemeData(
      color: injectedAppColorKeys.appTextColor.themeColor,
      size: 24.0,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>((
          Set<WidgetState> states,
        ) {
          if (states.contains(WidgetState.disabled)) {
            return Colors.grey;
          }
          return injectedAppColorKeys.appTextColor.themeColor;
        }),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: injectedAppTextStyles.regular14.copyWith(
        color: injectedAppColorKeys.appTextColor.themeColor,
      ),
      hintStyle: injectedAppTextStyles.medium14.copyWith(
        color: injectedAppColorKeys.appTextColor.themeColor,
      ),
    ),
    // Set the color scheme of the theme
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: injectedAppColorKeys.primaryColor.themeColor,
      brightness: brightness,
      onSurface: injectedAppColorKeys.appTextColor.themeColor,
      surface: injectedAppColorKeys.cardBackgroundColor.themeColor,
    ),
    // Set the date picker theme
    datePickerTheme: DatePickerThemeData(
      backgroundColor: injectedAppColorKeys.onPrimaryColor.themeColor,
      rangeSelectionBackgroundColor: injectedAppColorKeys
          .primaryColor
          .themeColor
          .withValues(alpha: 0.1),
      rangePickerBackgroundColor: scaffoldBackgroundColor,
      rangePickerHeaderBackgroundColor:
          injectedAppColorKeys.primaryColor.themeColor,
      rangePickerHeaderForegroundColor: scaffoldBackgroundColor,
      headerForegroundColor: injectedAppColorKeys.appTextColor.themeColor,
    ),

    // Set the app bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: scaffoldBackgroundColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: scaffoldBackgroundColor,
        statusBarIconBrightness: brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    ),
    // Set the dialog theme
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0.r)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: injectedAppColorKeys.primaryColor.themeColor,
      foregroundColor: scaffoldBackgroundColor,
    ),
  );

  ///
  ///Change the active Theme
  ///
  void changeTheme() =>
    injectedThemeEngine.updateThemeMode(isDarkMode: isDark.value);


  /* --------------------------------- GETTERS -------------------------------- */

  /// Light theme data getter
  ThemeData get lightTheme => _getThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: injectedAppColorKeys.scaffoldBackgroundColor.themeColor,
  );

  /// Dark theme data getter
  ThemeData get darkTheme => _getThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: injectedAppColorKeys.scaffoldBackgroundColor.themeColor,
  );

  /// Active theme data getter
  ThemeMode get activeTheme => !injectedThemeEngine.isDark.value ? ThemeMode.dark : ThemeMode.light;

  /// Active theme data getter
  ThemeData get activeThemeData => activeTheme == ThemeMode.dark ? darkTheme : lightTheme;


  void getActiveValue(ThemeMode mode) {
    isDark.value = mode == ThemeMode.dark;
  }

  ///
  /// Static getter to get the [ThemeViewModel] instance
  ///
  static ThemeViewModel of({bool listen = false}) => Provider.of<ThemeViewModel>(
    navigatorKey.currentContext!,
    listen: listen,
  );
}
