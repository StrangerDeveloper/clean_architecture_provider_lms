import 'dart:ui' show Color;

import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';

extension ThemeColorExt on String {
  Color get themeColor => injectedThemeEngine.getColor(this);
}
