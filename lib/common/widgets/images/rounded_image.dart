import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

class KRoundedImage extends StatelessWidget {
  static const defaultImageUrl =
      "https://png.pngtree.com/png-clipart/20190925/original/pngtree-no-image-vector-illustration-isolated-png-image_4979075.jpg";

  const KRoundedImage({
    super.key,
    this.border,
    this.padding,
    this.onPressed,
    this.width = 172,
    this.height = 158,
    this.applyImageRadius = true,
    this.imageUrl,
    this.fit = BoxFit.contain,
    this.backgroundColor,
    this.isNetworkImage = false,
    this.borderRadius = KSizes.md,
  });

  final double? width, height;
  final String? imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final imgUrl = imageUrl ?? defaultImageUrl;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: Image(
              width: width,
              height: height,
              fit: BoxFit.cover,
              image: isNetworkImage
                  ? NetworkImage(imgUrl)
                  : AssetImage(imgUrl) as ImageProvider),
        ),
      ),
    );
  }
}
