import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/layouts/list_layout.dart';
import 'package:gear_share_project/common/widgets/notifications/notifications_icon.dart';
import 'package:gear_share_project/features/shop/screens/search/widgets/category_button.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Szukaj',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          KNotificationCounterIcon(
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          ///Wyszukiwarka

          const KSearchContainer(
            showBackground: false,
            text: 'Szukaj',
          ),
          const SizedBox(
            height: KSizes.spaceBtwSections,
          ),

          ///Kategorie
          KListLayout(
              itemCount: 6,
              itemBuilder: (_, index) =>
                  KCategoryButton(title: 'Kategoria', onPressed: () {})),
        ],
      ),
    );
  }
}
