import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class KCircularIcon extends StatelessWidget {
  const KCircularIcon({
    super.key,
    this.width,
    this.height,
    this.size = KSizes.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    this.onPressed,
  });

  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor != null
            ? backgroundColor!
            : KHelperFunctions.isDarkMode(context)
                ? KColors.black.withOpacity(0.9)
                : KColors.white.withOpacity(0.9),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: color,
          size: size,
        ),
      ),
    );
  }
}
