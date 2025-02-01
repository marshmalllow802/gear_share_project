import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/utils/constants/routes.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

class KHomeCategories extends StatelessWidget {
  const KHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();

    return Obx(
      () {
        // Добавляем отладочную печать
        debugPrint('Categories length: ${controller.categories.length}');
        controller.categories.forEach((category) {
          debugPrint('Category: ${category.name}, Image: ${category.image}');
        });

        return SizedBox(
          height: 80,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final category = controller.categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: KSizes.spaceBtwItems),
                child: KVerticalImageText(
                    image: category.image,
                    title: category.name,
                    onTap: () => Get.toNamed(
                          KRoutes.category.replaceAll(':id', category.id),
                        )),
              );
            },
          ),
        );
      },
    );
  }
}
