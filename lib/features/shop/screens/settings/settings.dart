import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:gear_share_project/common/widgets/list_tiles/profil_menu_tile.dart';
import 'package:gear_share_project/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/authentication/screens/login/login.dart';
import 'package:gear_share_project/features/shop/screens/my_products/my_products.dart';
import 'package:gear_share_project/features/shop/screens/profile/profile.dart';
import 'package:gear_share_project/features/shop/screens/rented_products/rented_products_screen.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../favorites/favorites.dart';
import '../wallet/wallet_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Nagłówek
            KPrimaryHeaderContainer(
              child: Column(
                children: [
                  KAppBar(
                    title: Text(
                      'Profil',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: KColors.white),
                    ),
                  ),

                  ///Profil użytkownika
                  KUserProfileTitle(
                      onPressed: () => Get.to(() => const ProfileScreen())),
                  const SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            ///Body
            Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Column(
                children: [
                  ///---- Zarządzaj
                  const KSectionHeading(title: 'Zarządzaj'),
                  const SizedBox(
                    height: KSizes.spaceBtwItems,
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.heart,
                    title: 'Polubione ogłoszenia',
                    subTitle: 'Przeglądaj listę polubionych ogłoszeń',
                    onTap: () => Get.to(() => const FavoritesScreen()),
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.wallet,
                    title: 'Twój portfel',
                    subTitle: 'Zarządzaj swoimi środkami',
                    onTap: () => Get.to(() => const WalletScreen()),
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.book,
                    title: 'Historia pożyczeń',
                    subTitle: 'Przeglądaj listę polubionych ogłoszeń',
                    onTap: () {},
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Wypożyczone',
                    subTitle: 'Przeglądaj listę polubionych ogłoszeń',
                    onTap: () => Get.to(() => const RentedProductsScreen()),
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'Twoje ogłoszenia',
                    subTitle: 'Zarządzaj swoimi ogłoszeniami',
                    onTap: () => Get.to(() => const MyProductsScreen()),
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.star,
                    title: 'Opinie',
                    subTitle:
                        'Przeglądaj jaką ocenę masz otrzymując je od innych użytkowników',
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),

                  /// ------ Ustawienia aplikacji

                  const KSectionHeading(title: 'Ustawienia aplikacji'),
                  const SizedBox(
                    height: KSizes.spaceBtwItems,
                  ),

                  KProfileMenuTile(
                    icon: Iconsax.setting,
                    title: 'Ustawienia',
                    subTitle: 'Przeglądaj listę polubionych ogłoszeń',
                    onTap: () {},
                  ),
                  KProfileMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolokolizacja',
                    subTitle: 'Oglądaj ogłoszenia najbliżej swojej lokalizacji',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),

                  /// ---- Przycisk wylogowania
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                        onPressed: () => Get.to(() => const LoginScreen()), child: const Text('Wyloguj')),
                  ),
                  const SizedBox(
                    height: KSizes.spaceBtwSections * 2.5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
