import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';

class KCircularContainer extends StatelessWidget {
  const KCircularContainer({
    super.key,
    this.child,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0,
    this.backhroundColor = KColors.white,
  });

  final double? width;
  final double? height;
  final double radius;
  final double padding;
  final Widget? child;
  final Color backhroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backhroundColor,
      ),
      child: child,
    );
  }
}
