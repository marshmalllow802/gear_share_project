import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/signup/signup_controller.dart';

class KTermsAndContiionalsCheckbox extends StatelessWidget {
  const KTermsAndContiionalsCheckbox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = KHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
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
