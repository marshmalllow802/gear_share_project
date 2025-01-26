import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/common/widgets/loaders/loaders.dart';
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
  Future<void> signup() async {
    try {
      // Zacznij wczytywanie
      KFullScreenLoader.openLoadingDialog(
          'Analizujemy przeslana informacje...', KImages.lightLogo);

      // Sprawdz polaczenie internetowe(pozniej)

      // Walidacja formatki rejestracyjnej
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Sprawdz polityke prywatnosci
      if (!privacyPolicy.value) {
        KLoaders.warningSnackBar(
            title: 'Zaakceptuj polityke prywatnosci',
            message:
                'Aby założyć konto musisz zaakceptować Politykę prywatności oraz Warunki użytkowania');
      }

      // Zarejestruj uzytkownika do firebase authentication i zapisz dane uzytkownika w firebasie

      // Zapisz zautoryzowane dane uzytkownika w firebase firestore

      // Pokaz wiadomosc sukcesu
    } catch (e) {
      // Pokaz wygenerowany error
      KLoaders.errorSnackBar(title: 'Doszlo do pomylki', message: e.toString());
    } finally {
      // Usun loader
      KFullScreenLoader.stopLoading();
    }
  }
}
