import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/login_signup/form_divider.dart';
import 'package:gear_share_project/common/widgets/login_signup/social_buttons.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/constants/text_strings.dart';

import 'widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(KTexts.signUpTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Form
              const KSignupForm(),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Devider
              const KFormDevider(dividerText: KTexts.orSignUpWith),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Social button
              const KSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
