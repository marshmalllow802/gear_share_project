import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/screens/signup/verify_email.dart';
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
    return Form(
      child: Column(
        children: [
          Row(
            ///Imie i nazwisko
            children: [
              Expanded(
                child: TextFormField(
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
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.email, prefixIcon: Icon(Iconsax.direct)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///numer telefonu
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
          ),
          const SizedBox(
            height: KSizes.spaceBtwInputFields,
          ),

          ///hasło
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
                labelText: KTexts.password,
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: Icon(Iconsax.eye_slash)),
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
                onPressed: () => Get.to(() => const VerifyEmailScreen()),
                child: const Text(KTexts.createAccount)),
          )
        ],
      ),
    );
  }
}
