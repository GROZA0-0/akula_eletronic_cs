import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_in_page.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/main.dart';

class SignOutController extends GetxController {
  final AuthRepo repository;
  SignOutController(this.repository);

  final Alerts alerts = Alerts(messengerKey);
  Future<void> signOutTrigger() async {
    Loader.startLoading();
    try {
      await repository.signOut();
      clearAllControllers();
      // await Get.delete<FetchEmployeeInfoDashBoardController>(force: true);
      Loader.stopLoading();
      Get.offAll(
        () => const GradientBackground(child: SignInPage()),
        transition: naviStyleToAnotherPage,
      );
    } on FirebaseAuthException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } catch (e) {
      print("ANy other issues with signout $e");
    }
  }
}

void clearAllControllers() {
  if (Get.isRegistered<FetchEmployeeInfoDashBoardController>()) {
    Get.delete<FetchEmployeeInfoDashBoardController>(force: true);
  }
  if (Get.isRegistered<SignInController>()) {
    Get.delete<SignInController>(force: true);
  }
  print('controllers cleared');
}
