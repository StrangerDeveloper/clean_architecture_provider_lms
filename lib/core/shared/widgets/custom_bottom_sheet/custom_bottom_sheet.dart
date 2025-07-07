import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/extensions/navigator_ext/navigator_ext.dart';
import 'package:labor_management_system/core/extensions/space_xy/space_xy_ext.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';
import 'package:labor_management_system/core/extensions/translation_ext/translation_ext.dart';

import '../../../utils/global_utils/global_utils.dart';
import '../../../utils/injector_utils/injector_helper.dart';
import '../custom_button/custom_button.dart';
import '../custom_svg_icon/custom_svg_icon.dart';
import '../custom_text/custom_text.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  const CustomBottomSheetWidget({
    super.key,
    required this.title,
    this.primaryButtonCallback,
    this.secondaryButtonCallback,
    this.iconPath,
    this.primaryButtonText,
    this.secondaryButtonText,
    required this.showSingleButton,
    required this.hideBothButtons,
    required this.hideIcon,
    this.description,
    this.iconColor,
    this.padding,
  });

  final String title;
  final VoidCallback? primaryButtonCallback;
  final VoidCallback? secondaryButtonCallback;
  final String? iconPath;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final bool showSingleButton;
  final bool hideBothButtons;
  final bool hideIcon;
  final String? description;
  final Color? iconColor;
  final EdgeInsetsDirectional? padding;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextDirection>(
      valueListenable: injectedTranslationEngine.selectedLanguageDirection,
      builder: (context, textDirection, _) {
        return SafeArea(
          child: Padding(
            padding: padding ?? EdgeInsetsDirectional.all(20.0.w),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!hideIcon) ...[
                    CustomSvgIcon(
                      semanticsValue: injectedAppSemantics.bottomSheetIcon,
                      iconPath: iconPath,
                      width: 100.w,
                      height: 100.w,
                      color:
                          iconColor ??
                          injectedAppColorKeys.secondaryColor.themeColor,
                    ),
                    20.0.spaceY,
                  ],

                  CustomText(
                    text: title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                    textColor: injectedAppColorKeys.appTextColor.themeColor,
                  ),

                  if (description != null) ...[
                    20.0.spaceY,
                    CustomText(
                      text: description!,
                      maxLines: 8,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      textColor: injectedAppColorKeys.appTextColor.themeColor,
                    ),
                    32.0.spaceY,
                  ] else
                    32.0.spaceY,
                  if (!hideBothButtons) ...[
                    CustomButton(
                      text: primaryButtonText ?? injectedAppTranslationKeys.ok.translate,
                      onPressed: primaryButtonCallback ??
                              () {
                            navigatorKey.currentContext!.navigator.pop();
                          },
                    ),
                    if (!showSingleButton) ...[
                      12.0.spaceY,
                      CustomButton(
                        text: secondaryButtonText ?? injectedAppTranslationKeys.cancel.translate,
                        backgroundColor: injectedAppColorKeys.greyColor.themeColor,
                        textColor: injectedAppColorKeys.appTextColor.themeColor,
                        onPressed: secondaryButtonCallback ??
                                () {
                              navigatorKey.currentContext!.navigator.pop();
                            },
                      ),
                    ],
                  ],
                  32.0.spaceY,

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
