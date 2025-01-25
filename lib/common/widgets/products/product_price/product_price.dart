import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

class KProductPrice extends StatelessWidget {
  const KProductPrice(
      {super.key,
      required this.price,
      required this.unit,
      this.currencySign = 'zł',
      this.isLarge = false,
      this.maxLines = 1,
      this.lineThrough = false});

  final String unit, currencySign, price;
  final bool isLarge;
  final bool lineThrough;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          price + currencySign,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          style: isLarge
              ? Theme.of(context).textTheme.headlineSmall!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null)
              : Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: lineThrough ? TextDecoration.lineThrough : null),
        ),
        const SizedBox(width: KSizes.xs),
        Text(
          unit,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    );
  }
}
