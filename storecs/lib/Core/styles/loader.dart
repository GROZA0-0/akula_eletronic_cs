import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/styles/colors.dart';

class Loader {
  static bool isActive = false;

  static void startLoading() {
    if (isActive) return;
    isActive = true;

    Get.dialog(
      Center(child: LoadingAnimationWidget.beat(color: white, size: 55)),
      barrierDismissible: false,
    );
  }

  static void stopLoading() {
    if (!isActive) return;
    isActive = false;

    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
