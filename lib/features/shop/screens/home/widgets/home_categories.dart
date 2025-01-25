import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';

class KHomeCategories extends StatelessWidget {
  const KHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return KVerticaalImageText(
            image: KImages.categoryBooks,
            title: 'Ksiązki',
            onTap: () {},
          );
        },
      ),
    );
  }
}
