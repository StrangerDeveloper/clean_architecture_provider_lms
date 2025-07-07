import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:labor_management_system/core/extensions/theme_color/theme_color_ext.dart';

import '../../../utils/injector_utils/injector_helper.dart';
import '../custom_text/custom_text.dart';

/// A custom elevated button widget that allows for extensive customization.
///
/// The [CustomButton] widget provides a customizable elevated button
/// with options for setting text, background color, text style, padding, icons,
/// and more.
///
/// The following parameters are required:
/// - [text]: The text to display on the button.
/// - [onPressed]: The callback function to execute when the button is pressed.
///
/// Optional parameters include:
/// - [backgroundColor]: The background color of the button.
/// - [textStyle]: The style to use for the button's text.
/// - [textColor]: The color of the button's text.
/// - [textFontWeight]: The font weight of the button's text.
/// - [fontSize]: The font size of the button's text.
/// - [borderRadius]: The border radius of the button.
/// - [padding]: The padding inside the button.
/// - [leadingIcon]: A widget to display before the button's text.
/// - [trailingIcon]: A widget to display after the button's text.
/// - [mainAxisSize]: The main axis size of the button's row.
///

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.textColor,
    this.textFontWeight,
    this.fontSize,
    this.borderRadius,
    this.padding,
    this.leadingIcon,
    this.trailingIcon,
    this.mainAxisSize,
    this.minimumSize,
    this.width,
  });

  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final double? fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final MainAxisSize? mainAxisSize;
  final Size? minimumSize;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextDirection>(
      valueListenable: injectedTranslationEngine.selectedLanguageDirection,
      builder: (context, languageDirection, _) {
        return Semantics(
          value: "$text' Button",
          child: SizedBox(
            width: width,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    backgroundColor ??
                    injectedAppColorKeys.primaryColor.themeColor,
                minimumSize: minimumSize,
                padding:
                    padding ??
                    EdgeInsetsDirectional.symmetric(
                      horizontal: 16.0.w,
                      vertical: 13.0.w,
                    ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5.0.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: mainAxisSize ?? MainAxisSize.max,
                children: [
                  if (leadingIcon != null) ...[
                    leadingIcon!,
                    SizedBox(width: 8.0.w),
                  ],
                  CustomText(
                    text: text,
                    textColor:
                        textColor ??
                        injectedAppColorKeys.buttonTextColor.themeColor,
                    fontSize: fontSize,
                    fontWeight: textFontWeight ?? FontWeight.bold,
                    textStyle: textStyle,
                  ),
                  if (trailingIcon != null) ...[
                    SizedBox(width: 8.0.w),
                    trailingIcon!,
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
