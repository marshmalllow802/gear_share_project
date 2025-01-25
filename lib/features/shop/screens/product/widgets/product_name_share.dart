import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';

import '../../../../../utils/constants/sizes.dart';

class KProductNameAndShare extends StatelessWidget {
  const KProductNameAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const KProductTitleText(title: 'Wkrętarka G5S98'),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, size: KSizes.iconMd))
      ],
    );
  }
}
