import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/controllers/signup/signup_controller.dart';
import 'package:gear_share_project/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import 'terms_conditions_checkbox.dart';

class KSignupForm extends StatelessWidget {
  const KSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          Row(
            ///Imie i nazwisko
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => KValidator.validateEmptyText(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: KTexts.firstName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
              const SizedBox(
                width: KSizes.spaceBtwInputFields,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => KValidator.validateEmptyText(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: KTexts.lastName,
                      prefixIcon: Icon(Iconsax.user)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///nazwa uzytkownika
          TextFormField(
            controller: controller.userName,
            validator: (value) => KValidator.validateEmptyText(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.username,
                prefixIcon: Icon(Iconsax.user_edit)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///email
          TextFormField(
            controller: controller.email,
            validator: (value) => KValidator.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///numer telefonu
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => KValidator.validatePhoneNumber(value),
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///hasło
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
            height: KSizes.spaceBtwSections,
          ),

          ///terms&conditions
          const KTermsAndContiionalsCheckbox(),
          const SizedBox(
            height: KSizes.spaceBtwSections,
          ),

          ///pzycisk rejestracji
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(KTexts.createAccount)),
          )
        ],
      ),
    );
  }
}
