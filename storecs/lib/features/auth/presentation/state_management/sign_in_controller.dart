import 'package:get/get.dart';
import 'package:storecs/Core/config/bindings.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/dash_board/presentation/widgets/dash_board_widget.dart';
import 'package:storecs/main.dart';

class SignInController extends GetxController {
  final AuthRepo repo;
  SignInController(this.repo);
  final email = TextEditingController();
  final password = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);
  final auth = FirebaseAuth.instance;
  User? get authUser => auth.currentUser;

  Future<void> signInTrigger() async {
    if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
      alerts.ifErrors("All fields are required");
    } else if (email.text.trim().isEmpty) {
      alerts.ifErrors("Email field is required");
    } else if (password.text.trim().isEmpty) {
      alerts.ifErrors("Password fields is required");
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty) {
      Loader.startLoading();
      try {
        await repo.signInUsingEmail(email.text.trim(), password.text.trim());

        Loader.stopLoading();
        Get.offAll(
          () => GradientBackground(child: DashboardWidgets()),
          transition: naviStyleToAnotherPage,
          binding: AppBindingsControllers(),
        );
        email.clear();
        password.clear();
      } on PlatformException catch (e) {
        print('The Error Is: ${e.message.toString()}');
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      } catch (e) {
        Loader.stopLoading();
        print("sign in issue $e");
        alerts.ifErrors("Something went wrong.");
      } finally {
        Loader.stopLoading();
      }
    }
  }
}
