import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';

class KFullScreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      barrierColor: Colors.black45,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: KAnimationLoaderWidget(text: text, animation: animation),
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    if (Get.isDialogOpen == true) {
      Navigator.of(Get.overlayContext!).pop();
    }
  }
}
