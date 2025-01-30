import 'package:flutter/material.dart';
import 'package:gear_share_project/features/personalization/controllers/user_controller.dart';
import 'package:get/get.dart';

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
    final controller = Get.put(UserController());
    return KAppBar(
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(KTexts.homeAppBarTitle,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: KColors.softGrey)),
        Obx(
          () => Text(controller.user.value.fullName,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: KColors.white)),
        ),
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
