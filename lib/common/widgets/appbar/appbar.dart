import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/device/device_utility.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar(
      {super.key,
      this.title,
      this.showBackArror = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed,
      this.backgroundColor = Colors.transparent,
      this.showBackArrowWithBackground = false});

  final Widget? title;
  final bool showBackArror;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? backgroundColor;
  final bool showBackArrowWithBackground;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: showBackArror || leadingIcon != null
            ? showBackArrowWithBackground
                ? KCircularIcon(
                    icon: leadingIcon ?? Icons.arrow_back,
                    color: dark ? KColors.white : KColors.black,
                    backgroundColor: dark ? KColors.dark : KColors.white,
                    onPressed: leadingOnPressed ?? () => Navigator.pop(context),
                  )
                : IconButton(
                    onPressed: leadingOnPressed ?? () => Navigator.pop(context),
                    icon: Icon(leadingIcon ?? Icons.arrow_back),
                  )
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
