import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/images/circular_image.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/shop/screens/profile/widgets/profile_menu.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        showBackArror: true,
        title: Text('Twoje konto'),
      ),

      ///Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              /// Zdjęcie użytkownika
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const KCircularImage(
                      image: KImages.userImage,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Zmień zdjęcie profilowe')),
                  ],
                ),
              ),

              ///Szczegóły
              const SizedBox(height: KSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: KSizes.spaceBtwItems),
              const KSectionHeading(title: 'Informacja o profilu'),
              const SizedBox(height: KSizes.spaceBtwItems),

              KProfileMenu(
                  title: 'Imię', value: 'Karina Vakhonina', onPressed: () {}),
              KProfileMenu(
                  title: 'Nazwa użytkowinika',
                  value: 'marshmallow',
                  onPressed: () {}),

              const SizedBox(height: KSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: KSizes.spaceBtwItems),

              const KSectionHeading(title: 'Informacja personalna'),
              const SizedBox(height: KSizes.spaceBtwItems),

              KProfileMenu(
                  title: 'User ID',
                  value: '45678',
                  icon: Iconsax.copy,
                  onPressed: () {}),
              KProfileMenu(
                  title: 'E-mail', value: 'student@dsw.com', onPressed: () {}),
              KProfileMenu(
                  title: 'Numer telefonu',
                  value: '321 654 987',
                  onPressed: () {}),
              KProfileMenu(
                  title: 'Data urodzenia',
                  value: '23.09.1998',
                  onPressed: () {}),

              const SizedBox(height: KSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Usuń konto',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
