import 'package:flutter/material.dart';
import 'package:gear_share_project/features/shop/screens/add_screen/add_screen.dart';
import 'package:gear_share_project/features/shop/screens/home/home.dart';
import 'package:gear_share_project/features/shop/screens/settings/settings.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'features/shop/screens/search/search.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = KHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) {
            if (index == 2) {
              // Przejście do ekranu "Dodaj" bez menu nawigacyjnego
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddScreen()),
              );
            } else {
              controller.selectedIndex.value = index;
            }
          },
          backgroundColor: darkMode ? KColors.black : Colors.white,
          indicatorColor: darkMode
              ? KColors.white.withOpacity(0.1)
              : KColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Nowości'),
            NavigationDestination(
                icon: Icon(Iconsax.search_normal), label: 'Szukaj'),
            NavigationDestination(
                icon: Icon(Iconsax.add_circle), label: 'Dodaj'),
            NavigationDestination(
                icon: Icon(Iconsax.messages4), label: 'Wiadomości'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profil'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    const SearchScreen(),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.purple,
    ),
    const SettingsScreen(),
  ];
}
