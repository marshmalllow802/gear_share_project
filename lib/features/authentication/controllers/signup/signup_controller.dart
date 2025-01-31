import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/common/widgets/loaders/loaders.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/data/repositories/user/user_repository.dart';
import 'package:gear_share_project/features/authentication/screens/signup/verify_email.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/popups/full_screen_loader.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Variables
  final hidePassword = true.obs;
  final privacyPolicy = true.obs;
  final email = TextEditingController();
  final userName = TextEditingController();
  final lastName = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Rejestracja
  void signup() async {
    // Zacznij wczytywanie
    KFullScreenLoader.openLoadingDialog(
        'Analizujemy przeslana informacje...', KImages.loader);

    // Sprawdz polaczenie internetowe(pozniej)

    // Walidacja formatki rejestracyjnej
    if (!signupFormKey.currentState!.validate()) {
      // Usun loader
      KFullScreenLoader.stopLoading();
      return;
    }

    // Sprawdz polityke prywatnosci
    if (!privacyPolicy.value) {
      KLoaders.warningSnackBar(
          title: 'Zaakceptuj polityke prywatnosci',
          message:
              'Aby założyć konto musisz zaakceptować Politykę prywatności oraz Warunki użytkowania');
      return;
    }

    // Zarejestruj uzytkownika do firebase authentication i zapisz dane uzytkownika w firebasie
    final userCredential = await AuthenticationRepository.instance
        .registerWithEmailAndPassword(email.text.trim(), password.text.trim());
    // Zapisz zautoryzowane dane uzytkownika w firebase firestore

    debugPrint("userCredential: $userCredential");
    final newUser = UserModel(
      id: userCredential.user!.uid,
      firstName: firstName.text.trim(),
      lastName: lastName.text.trim(),
      username: userName.text.trim(),
      email: email.text.trim(),
      phoneNumber: phoneNumber.text.trim(),
      profilePicture: '',
    );

    final userRepository = Get.put(UserRepository());
    await userRepository.saveUserRecord(newUser);

    // Usun loader
    KFullScreenLoader.stopLoading();

    // Pokaz wiadomosc sukcesu

    KLoaders.successSnackBar(
        title: 'Gratulacje!',
        message:
            'Twoje konto zostało stworzone. Zweryfikuj swój email aby kontynuować');

    Get.to(() => const VerifyEmailScreen());
  }
}
