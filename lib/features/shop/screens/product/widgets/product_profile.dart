import 'package:flutter/material.dart';
import 'package:gear_share_project/common/styles/shadow_styles.dart';
import 'package:gear_share_project/common/widgets/images/circular_image.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class KProductProfile extends StatelessWidget {
  const KProductProfile(
      {super.key,
      required this.username,
      required this.rating,
      required this.numberOfRatings,
      required this.itemsLent,
      required this.itemsBorrowed,
      required this.itemsCanceled});

  final String username;
  final double rating;
  final int numberOfRatings;
  final int itemsLent;
  final int itemsBorrowed;
  final int itemsCanceled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      decoration: BoxDecoration(
        color: KColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [KShadowStyle.horizontaProductShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const KCircularImage(
                image: KImages.userImage,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: KSizes.spaceBtwItems / 2),
              Text(
                username,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: KColors.black),
              )
            ],
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          Row(
            children: [
              const Icon(Iconsax.star5,
                  color: Colors.amber, size: KSizes.iconSm),
              const SizedBox(width: KSizes.spaceBtwItems / 2),
              Text(
                rating.toStringAsFixed(1),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: KColors.black),
              ),
              const SizedBox(width: KSizes.spaceBtwItems / 2),
              Text(
                '($numberOfRatings)',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: KColors.grey),
              ),
            ],
          ),
          const SizedBox(height: KSizes.spaceBtwItems / 2),
          const Divider(),
          const SizedBox(height: KSizes.spaceBtwItems / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildItemStat(context, 'Wypożyczył', itemsLent),
              _buildVerticalDivider(),
              _buildItemStat(context, 'Od kogoś', itemsBorrowed),
              _buildVerticalDivider(),
              _buildItemStat(context, 'Odwołano', itemsCanceled)
            ],
          )
        ],
      ),
    );
  }
}

Widget _buildItemStat(BuildContext context, String label, int value) {
  return Column(
    children: [
      Text('$value',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: KColors.black)),
      const SizedBox(height: KSizes.spaceBtwItems / 2),
      Text(label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .apply(color: KColors.grey)),
    ],
  );
}

Widget _buildVerticalDivider() {
  return Container(
    height: 48.0,
    width: 1.0,
    color: Colors.grey.withOpacity(0.5),
  );
}
