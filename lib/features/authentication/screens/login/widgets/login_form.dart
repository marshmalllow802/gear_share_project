import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:gear_share_project/features/authentication/screens/signup/signup.dart';
import 'package:gear_share_project/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class KLoginForm extends StatelessWidget {
  const KLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: KTexts.email,
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields,
            ),

            ///Password
            TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: KTexts.password,
                suffixIcon: Icon(Iconsax.eye_slash),
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields / 2,
            ),

            ///Remember me & forget password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///Remember me
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(KTexts.rememberMe),
                  ],
                ),

                ///Forget Password
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(KTexts.forgetPassword),
                )
              ],
            ),
            const SizedBox(height: KSizes.spaceBtwSections),

            ///Sign in Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const NavigationMenu()),
                  child: const Text(KTexts.signIn),
                )),
            const SizedBox(height: KSizes.spaceBtwItems),

            ///Create account button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Get.to(() => const SignupScreen()),
                  child: const Text(KTexts.createAccount),
                )),
          ],
        ),
      ),
    );
  }
}
