import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/images/circular_image.dart';
import 'package:gear_share_project/features/personalization/controllers/user_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';

class KUserProfileTitle extends StatelessWidget {
  const KUserProfileTitle({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: const KCircularImage(
        image: KImages.userImage,
        width: 50,
        height: 50,
      ),
      title: Text(
        controller.user.value.fullName,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: KColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: KColors.white),
      ),
      trailing: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Iconsax.edit,
          color: KColors.white,
        ),
      ),
    );
  }
}
