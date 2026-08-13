import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:storecs/Core/Styles/alerts.dart';

import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_in_page.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/dash_board/domain/repository/employee_info_repo.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/main.dart';

class SignOutController {
  final AuthRepo repository;
  final EmployeeInfoRepo employeeInfoRepo;
  SignOutController(this.repository, this.employeeInfoRepo);
  final Alerts alerts = Alerts(messengerKey);
  Future<void> signOutTrigger() async {
    Loader.startLoading();
    try {
      await repository.signOut();
      clearAllControllers(repository, employeeInfoRepo);
      // await Get.delete<FetchEmployeeInfoDashBoardController>(force: true);
      Loader.stopLoading();
      Navigator.pushAndRemoveUntil(
        navigator!.context,
        naviToAnotherPage(SignInPage()),
        (route) => false,
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

void clearAllControllers(
  AuthRepo repository,
  EmployeeInfoRepo employeeInfoRepo,
) {
  final sl = GetIt.instance;
  if (sl.isRegistered<FetchEmployeeInfoDashBoardController>()) {
    sl.unregister<FetchEmployeeInfoDashBoardController>();
  }
  sl.registerFactory<FetchEmployeeInfoDashBoardController>(
    () => FetchEmployeeInfoDashBoardController(repository: employeeInfoRepo),
  );
  if (sl.isRegistered<SignInController>()) {
    sl.unregister<SignInController>();
  }
  sl.registerFactory<SignInController>(() => SignInController(repository));
  print('controllers cleared');
}
