import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class KLoginHeader extends StatelessWidget {
  const KLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? KImages.lightLogo : KImages.darkLogo),
        ),
        Text(KTexts.loginTitle,
            style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: KSizes.sm),
        Text(KTexts.loginSubTitle,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
