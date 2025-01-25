import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class KTermsAndContiionalsCheckbox extends StatelessWidget {
  const KTermsAndContiionalsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: KSizes.spaceBtwItems,
        ),
        Flexible(
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: '${KTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${KTexts.privacyPolicy} ',
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? KColors.white : KColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? KColors.white : KColors.primary,
                    )),
            TextSpan(
                text: '${KTexts.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: KTexts.termsOfUse,
                style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? KColors.white : KColors.primary,
                      decoration: TextDecoration.underline,
                      decorationColor: dark ? KColors.white : KColors.primary,
                    )),
          ])),
        ),
      ],
    );
  }
}
