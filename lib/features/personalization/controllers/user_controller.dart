import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/loaders/loaders.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/data/repositories/user/user_repository.dart';
import 'package:gear_share_project/features/authentication/screens/login/login.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final imageUploading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    final user = await userRepository.fetchUserDetails();
    this.user(user);
  }

  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    await fetchUserRecord();
    if (user.value.id.isEmpty) {
      if (userCredentials != null) {
        final nameParts =
            UserModel.nameParts(userCredentials.user!.displayName ?? '');
        final username =
            UserModel.generateUserName(userCredentials.user!.displayName ?? '');

        final user = UserModel(
          id: userCredentials.user!.uid,
          firstName: nameParts[0],
          lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
          username: username,
          email: userCredentials.user!.email ?? '',
          phoneNumber: userCredentials.user!.phoneNumber ?? '',
          profilePicture: userCredentials.user!.photoURL ?? '',
        );

        await userRepository.saveUserRecord(user);
      }
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(KSizes.md),
        title: 'Delete Account',
        middleText:
            'Czy jesteś pewny, że chcesz usunąć konto? To jest nieodwracalne i wszystkie twoje dane zostaną usunięte.',
        confirm: ElevatedButton(
          onPressed: () async => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              side: const BorderSide(color: Colors.red)),
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: KSizes.lg),
              child: Text('Usuń')),
        ),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Anuluj')));
  }

  void deleteUserAccount() async {
    final auth = AuthenticationRepository.instance;
    final provider = auth.authUser!.providerData.map((e) => e.providerId).first;

    if (provider.isNotEmpty) {
      AuthenticationRepository.instance.deleteAccount;
      Get.offAll(() => const LoginScreen());
    }
  }

  uploadUserProfilePicture() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512);
    if (image != null) {
      imageUploading.value = true;
      final imageUrl =
          await userRepository.uploadImage('Users/Images/Profile/', image);

      Map<String, dynamic> json = {'ProfilePicture': imageUrl};
      await userRepository.updateSingleField(json);

      user.value.profilePicture = imageUrl;
      user.refresh();
      KLoaders.successSnackBar(
          title: 'Gratulacje', message: 'Zdjęcie profilowe zostało zmienione!');
    }
    imageUploading.value = false;
  }
}
