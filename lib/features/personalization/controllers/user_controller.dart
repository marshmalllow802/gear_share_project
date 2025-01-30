import 'package:firebase_auth/firebase_auth.dart';
import 'package:gear_share_project/data/repositories/user/user_repository.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

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
