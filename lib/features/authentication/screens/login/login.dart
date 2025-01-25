import 'package:flutter/material.dart';
import 'package:gear_share_project/common/styles/spacing_styles.dart';
import 'package:gear_share_project/common/widgets/login_signup/form_divider.dart';
import 'package:gear_share_project/features/authentication/screens/login/widgets/login_header.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/constants/text_strings.dart';
import 'widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: KSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo, Title&Sub-title
              KLoginHeader(),

              ///Form
              KLoginForm(),

              ///Divider
              KFormDevider(dividerText: KTexts.orSignInWith),
              SizedBox(height: KSizes.spaceBtwSections),

              ///Footer
              KSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
