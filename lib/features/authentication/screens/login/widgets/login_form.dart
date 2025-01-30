import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/controllers/login/login_controller.dart';
import 'package:gear_share_project/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:gear_share_project/features/authentication/screens/signup/signup.dart';
import 'package:gear_share_project/utils/validators/validation.dart';
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
    final controller = Get.put(LoginController());

    return Form(
      key: controller.loginFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: KSizes.spaceBtwSections),
        child: Column(
          children: [
            ///Email
            TextFormField(
              controller: controller.email,
              validator: (value) => KValidator.validateEmail(value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: KTexts.email,
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwInputFields,
            ),

            ///Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => KValidator.validatePassword(value),
                obscureText: controller.hidePassword.value,
                decoration: InputDecoration(
                  labelText: KTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                        !controller.hidePassword.value,
                    icon: Icon(controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
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
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
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
                  onPressed: () => controller.login(),
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

            /*SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: "test6@test6.com", password: "Test6^");
                    debugPrint('Zalogowano: $userCredential');
                  },
                  child: const Text('Testuj logowanie'),
                ))*/
          ],
        ),
      ),
    );
  }
}
