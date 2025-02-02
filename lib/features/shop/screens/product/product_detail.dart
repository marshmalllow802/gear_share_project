import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_attributes.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_meta_data.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_name_share.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_profile.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';
import '../../services/firebase_service.dart';
import 'widgets/product_detail_image_slider.dart';

class ProductDetail extends StatelessWidget {
  final String? id;

  const ProductDetail({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ProductModel?>(
        future: id != null
            ? Get.find<FirebaseService>().getProduct(id!)
            : Future.value(ProductModel.empty()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final product = snapshot.data ?? ProductModel.empty();
          return SingleChildScrollView(
            child: Column(
              children: [
                /// Zdjęcia produktu
                KProductImageSlider(product: product),

                Padding(
                  padding: const EdgeInsets.only(
                      right: KSizes.defaultSpace,
                      left: KSizes.defaultSpace,
                      bottom: KSizes.defaultSpace),
                  child: Column(
                    children: [
                      ///Nazwa produktu i udostępnij
                      KProductNameAndShare(product: product),

                      ///cena, status, lokalizacja
                      KProductMetaData(product: product),
                      const SizedBox(height: KSizes.spaceBtwSections),

                      /// atrybuty wariacje
                      KProductAttributes(product: product),
                      const SizedBox(height: KSizes.spaceBtwSections),

                      ///opis
                      const KSectionHeading(title: 'Opis produktu'),
                      const SizedBox(height: KSizes.spaceBtwItems),
                      ReadMoreText(
                        product.description,
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Więcej',
                        trimExpandedText: 'Mniej',
                        moreStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                        lessStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),

                      ///opinie
                    ],
                  ),
                ),

                FutureBuilder<UserModel?>(
                  future: Get.find<FirebaseService>().getUser(product.author),
                  builder: (context, userSnapshot) {
                    final username =
                        userSnapshot.data?.username ?? 'Unknown User';
                    return KProductProfile(
                      username: username,
                      rating: 5.0,
                      numberOfRatings: 186,
                      itemsLent: 33,
                      itemsBorrowed: 29,
                      itemsCanceled: 0,
                    );
                  },
                ),
                const SizedBox(height: KSizes.spaceBtwItems),
                Padding(
                  padding: const EdgeInsets.only(
                      right: KSizes.defaultSpace,
                      left: KSizes.defaultSpace,
                      bottom: KSizes.defaultSpace),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      KSectionHeading(title: 'Opinie (186)', onPressed: () {}),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: KSizes.spaceBtwSections),
              ],
            ),
          );
        },
      ),
    );
  }
}
