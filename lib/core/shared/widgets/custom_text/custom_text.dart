import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/injector_utils/injector_helper.dart';

/// A custom text widget that allows for extensive customization of text appearance and behavior.
///
/// The [CustomText] widget provides various properties to customize the text, including color,
/// font size, font weight, font style, text alignment, text overflow, maximum lines, text decoration,
/// background color, padding, and an optional tap callback.
///
/// The [text] parameter is required and specifies the text to be displayed.
///
/// The [textColor] parameter specifies the color of the text. If not provided, the default color is used.
///
/// The [fontSize] parameter specifies the size of the text. If not provided, the default size is used.
///
/// The [fontWeight] parameter specifies the weight of the font. If not provided, the default weight is used.
///
/// The [fontStyle] parameter specifies the style of the font (e.g., italic). If not provided, the default style is used.
///
/// The [textAlign] parameter specifies the alignment of the text. If not provided, the default alignment is used.
///
/// The [onTap] parameter specifies a callback function to be called when the text is tapped. If not provided, the text is not tappable.
///
/// The [overflow] parameter specifies how the text should be truncated if it overflows its container. If not provided, the default overflow behavior is used.
///
/// The [maxLines] parameter specifies the maximum number of lines for the text. If not provided, the text can have unlimited lines.
///
/// The [decoration] parameter specifies the decoration to be applied to the text (e.g., underline). If not provided, no decoration is applied.
///
/// The [height] parameter specifies the height of the text line. If not provided, the default height is used.
///
/// The [backgroundColor] parameter specifies the background color of the text container. If not provided, the background is transparent.
///
/// The [decorationColor] parameter specifies the color of the text decoration. If not provided, the default decoration color is used.
///
/// The [padding] parameter specifies the padding around the text. If not provided, no padding is applied.
class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.textColor,
    this.fontSize,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.fontStyle,
    this.onTap,
    this.overflow,
    this.decoration,
    this.height,
    this.backgroundColor,
    this.decorationColor,
    this.padding,
    this.textStyle,
    this.textDirection,
  });

  final String text;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;
  final double? height;
  final Color? backgroundColor;
  final Color? decorationColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextDirection>(
      valueListenable: injectedTranslationEngine.selectedLanguageDirection,
      builder: (context, languageDirection, _) {
        return ColoredBox(
          color: backgroundColor ?? Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: padding ?? EdgeInsetsDirectional.zero,
              child: Text(
                text,
                overflow: overflow,
                maxLines: maxLines,
                textAlign: textAlign,
                textDirection: textDirection ?? languageDirection,
                style: textStyle ??
                    injectedAppTextStyles.getActiveTextStyle(
                      color: textColor,
                      fontSize: fontSize ?? 14.0.sp,
                      fontWeight: fontWeight ?? FontWeight.w500,
                      fontStyle: fontStyle,
                      decoration: decoration,
                      decorationColor: decorationColor,
                      decorationThickness: 2,
                      decorationStyle: TextDecorationStyle.solid,
                      height: height,
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
