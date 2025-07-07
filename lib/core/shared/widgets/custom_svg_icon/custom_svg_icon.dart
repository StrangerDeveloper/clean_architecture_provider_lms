import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:labor_management_system/core/utils/global_utils/global_utils.dart';

import '../../../utils/injector_utils/injector_helper.dart';
import '../material_base/material_base.dart';

/// A custom widget that displays an SVG icon with optional color customization.
///
/// The [CustomSvgIcon] widget takes an optional [iconPath] and [color] to display
/// an SVG icon. If [iconPath] is not provided, a default icon from the [AppIcons]
/// injector is used. Similarly, if [color] is not provided, a default color from
/// the [AppColors] injector is used.
///
/// The [iconPath] parameter specifies the path to the SVG asset.
/// The [color] parameter specifies the color to apply to the SVG icon.
///
/// Example usage:
/// ```dart
/// CustomSvgIcon(
///   iconPath: 'assets/icons/my_icon.svg',
///   color: Colors.red,
/// )
/// ```

class CustomSvgIcon extends StatelessWidget {
  const CustomSvgIcon({
    super.key,
    this.iconPath,
    this.color,
    this.width,
    this.height,
    this.semanticsValue,
    this.onTap,
    this.scale,
    this.usingLanguageDirection = false,
    this.removeSplashColor = false,
  });

  final String? iconPath;
  final Color? color;
  final double? width;
  final double? height;
  final String? semanticsValue;
  final VoidCallback? onTap;
  final double? scale;
  final bool usingLanguageDirection;
  final bool removeSplashColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextDirection>(
      valueListenable: injectedTranslationEngine.selectedLanguageDirection,
      builder: (context, textDirection, child) {
        return MaterialBase(
          onTap: onTap,
          removeSplashColor: removeSplashColor,
          child: Semantics(
            value: semanticsValue ?? getImageSemanticValue(iconPath),
            child: Transform.flip(
              flipX:
                  textDirection == TextDirection.rtl && usingLanguageDirection,
              child: Transform.scale(
                scale: scale ?? 1,
                child: SvgPicture.asset(
                  iconPath ??
                      (injectedThemeEngine.isDark.value == true
                          ? injectedAppIcons.appErrorAlertDark
                          : injectedAppIcons.alertIcon),
                  width: width ?? 80.w,
                  height: height ?? 80.w,
                  colorFilter: color == null
                      ? null
                      : ColorFilter.mode(color!, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
