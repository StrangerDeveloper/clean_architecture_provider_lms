import 'package:flutter/material.dart';
import 'package:labor_management_system/core/utils/injector_utils/injector_helper.dart';

import '../../../utils/global_utils/global_utils.dart';

class CustomAssetImage extends StatelessWidget {
  const CustomAssetImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.onTap,
    this.semanticValue,
  });

  final String imagePath;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final VoidCallback? onTap;
  final String? semanticValue;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      value: semanticValue ?? getImageSemanticValue(imagePath),
      image: true,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
        cacheHeight: cacheHeight,
        cacheWidth: cacheWidth,
        fit: fit,
        errorBuilder: (_, _, _) {
          return Image.asset(
            injectedAppIcons.noImage,
            width: width,
            height: height,
          );
        },
        frameBuilder: (_, child, frame, _) {
          if (frame == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return child;
        },
      ),
    );
  }
}


