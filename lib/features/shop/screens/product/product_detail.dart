import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/bottom_propose_offer.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_atributes.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_meta_data.dart';
import 'package:gear_share_project/features/shop/screens/product/widgets/product_profile.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

import 'widgets/product_detail_image_slider.dart';
import 'widgets/product_name_share.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: const KBottomProposeOffer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Zdjęcia produktu
            const KProductImageSlider(),

            const Padding(
              padding: EdgeInsets.only(
                  right: KSizes.defaultSpace,
                  left: KSizes.defaultSpace,
                  bottom: KSizes.defaultSpace),
              child: Column(
                children: [
                  ///Nazwa produktu i udostępnij
                  KProductNameAndShare(),

                  ///cena, status, lokalizacja
                  KProductMetaData(),
                  SizedBox(height: KSizes.spaceBtwSections),

                  /// atrybuty wariacje
                  KProductAttributes(),
                  SizedBox(height: KSizes.spaceBtwSections),

                  ///opis
                  KSectionHeading(title: 'Opis produktu'),
                  SizedBox(height: KSizes.spaceBtwItems),
                  ReadMoreText(
                    'retdryfugyiuoijpo dtyfugyioi tfuo tiyo werytuyuiodfghuj rtyuit tyuiotyuio rtyuiortyu rtyuiotyui rtrukyil ky ruiyuio fgyh erytuygiuhoiiyo tlup9up9tty rytuyuoityu rtuyiui ty8yo ruyoup rtoup ruyoiup[]',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Więcej',
                    trimExpandedText: 'Mniej',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  ///opinie
                ],
              ),
            ),

            const KProductProfile(
              username: 'marshmallow',
              rating: 5.0,
              numberOfRatings: 186,
              itemsLent: 33,
              itemsBorrowed: 29,
              itemsCanceled: 0,
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
                KSectionHeading(title: 'Opinie (186)', onPressed: (){}),
                IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3, size: 18,))
              ],
            ),
      ),
            const SizedBox(height: KSizes.spaceBtwSections),

          ],
        ),
      ),
    );
  }
}
