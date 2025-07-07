import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';
import '../../shared/widgets/custom_bottom_sheet/custom_bottom_sheet.dart';
import '../global_utils/global_utils.dart';
import '../injector_utils/injector_helper.dart';

void showCustomBottomSheet({
  final String title = '',
  final bool isDismissible = false,
  final bool enableDrag = false,
  final VoidCallback? primaryButtonCallback,
  final VoidCallback? secondaryButtonCallback,
  final String? iconPath,
  final String? primaryButtonText,
  final String? secondaryButtonText,
  final bool showSingleButton = false,
  final bool hideBothButtons = false,
  final String? description,
  final Color? iconColor,
  final EdgeInsetsDirectional? padding,
  final Widget? bottomSheetContent,
  final bool hideIcon = false,
}) {
  showModalBottomSheet(
    enableDrag: enableDrag,
    isDismissible: isDismissible,
    context: navigatorKey.currentContext!,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
    ),
    constraints: BoxConstraints(maxWidth: 1.0.sw),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    backgroundColor: injectedAppColorKeys.bottomSheetColor.themeColor,
    builder: (context) {
      return PopScope(
        canPop: false,
        child:
            bottomSheetContent ??
            CustomBottomSheetWidget(
              title: title,
              primaryButtonCallback: primaryButtonCallback,
              iconPath: iconPath,
              primaryButtonText: primaryButtonText,
              secondaryButtonText: secondaryButtonText,
              showSingleButton: showSingleButton,
              description: description,
              iconColor: iconColor,
              padding: padding,
              hideBothButtons: hideBothButtons,
              secondaryButtonCallback: secondaryButtonCallback,
              hideIcon: hideIcon,
            ),
      );
    },
  );
}
