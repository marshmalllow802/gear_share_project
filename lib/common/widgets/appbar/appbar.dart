import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/device/device_utility.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar(
      {super.key,
      this.title,
      this.showBackArror = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed});

  final Widget? title;
  final bool showBackArror;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArror
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Iconsax.arrow_left,
                    color: dark ? KColors.white : KColors.dark))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed, icon: Icon(leadingIcon))
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(KDeviceUtilities.getAppBarHeight());
}
