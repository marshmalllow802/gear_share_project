import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/bottom_propose_offer.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_attributes.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_meta_data.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_name_share.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/texts/product_title_text.dart';
import '../../models/product_model.dart';
import '../../services/firebase_service.dart';
import 'widgets/product_detail_image_slider.dart';

class ProductDetail extends StatelessWidget {
  final String? id;

  const ProductDetail({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();

    return FutureBuilder<ProductModel?>(
      future: firebaseService.getProduct(id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(child: Text('Nie znaleziono produktu')),
          );
        }

        final product = snapshot.data!;

        return Scaffold(
          bottomNavigationBar: KBottomProposeOffer(product: product),
          body: SingleChildScrollView(
            child: Column(
              children: [
                /// Slider zdjęć produktu
                KProductImageSlider(product: product),

                /// Szczegóły produktu
                Padding(
                  padding: const EdgeInsets.only(
                    right: KSizes.defaultSpace,
                    left: KSizes.defaultSpace,
                    bottom: KSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      /// -- Name & share button
                      KProductNameAndShare(product: product),

                      /// Tytuł i cena
                      KProductTitleText(title: product.title),
                      const SizedBox(height: KSizes.spaceBtwItems),

                      /// Metadane produktu
                      KProductMetaData(product: product),
                      const SizedBox(height: KSizes.spaceBtwSections),

                      /// Atrybuty
                      KProductAttributes(product: product),
                      const SizedBox(height: KSizes.spaceBtwSections),

                      /// Opis
                      const KSectionHeading(title: 'Opis produktu'),
                      const SizedBox(height: KSizes.spaceBtwItems),
                      ReadMoreText(
                        product.description,
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Więcej',
                        trimExpandedText: 'Mniej',
                        moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                        lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
