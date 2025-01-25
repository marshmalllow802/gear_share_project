import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class KNotificationCounterIcon extends StatelessWidget {
  const KNotificationCounterIcon({
    super.key,
    required this.onPressed,
    this.lightModeColor = KColors.black,
    this.darkModeColor = KColors.white,
  });

  final VoidCallback onPressed;
  final Color? lightModeColor;
  final Color? darkModeColor;

  @override
  Widget build(BuildContext context) {
    final darkMode = KHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
            onPressed: onPressed,
            icon: Icon(
              Iconsax.notification,
              color: darkMode ? darkModeColor : lightModeColor,
            )),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: KColors.warning.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text('3',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: KColors.white, fontSizeFactor: 0.8)),
            ),
          ),
        )
      ],
    );
  }
}
