import 'package:flutter/material.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';

import '../../../utils/injector_utils/injector_helper.dart';

class MaterialBase extends StatelessWidget {
  const MaterialBase({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.shadowColor,
    this.elevation = 0,
    this.splashColor,
    this.removeSplashColor = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? shadowColor;
  final double elevation;
  final Color? splashColor;
  final bool removeSplashColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: injectedAppColors.transparent,
      elevation: elevation,
      shadowColor:
          shadowColor ??
          (injectedAppColorKeys.shadowColor.themeColor).withValues(alpha: 0.5),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        splashColor: removeSplashColor ? Colors.transparent : splashColor,
        child: child,
      ),
    );
  }
}
