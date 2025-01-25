import 'package:flutter/material.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class KHomeAppBar extends StatelessWidget {
  const KHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return KAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(KTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: KColors.softGrey)),
        Text(KTexts.homeAppBarSubTitle,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: KColors.white)),
      ]),
      actions: [
        KNotificationCounterIcon(
          lightModeColor: KColors.white,
          darkModeColor: KColors.white,
          onPressed: () {},
        )
      ],
    );
  }
}
