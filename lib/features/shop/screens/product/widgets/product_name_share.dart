import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

class KProductNameAndShare extends StatelessWidget {
  final ProductModel product;

  const KProductNameAndShare({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        KProductTitleText(title: product.title),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, size: KSizes.iconMd))
      ],
    );
  }
}
