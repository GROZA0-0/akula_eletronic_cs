import 'package:get/get.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/dash_board/presentation/widgets/dash_board_widget.dart';
import 'package:storecs/main.dart';

class SignInController extends ChangeNotifier {
  final AuthRepo repo;
  SignInController(this.repo);
  final email = TextEditingController();
  final password = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);
  final auth = FirebaseAuth.instance;
  User? get authUser => auth.currentUser;
  bool isPassVisible = true;

  Future<void> signInTrigger() async {
    if (email.text.trim().isEmpty) {
      alerts.ifErrors("Email field is required");
      return;
    } else if (password.text.trim().isEmpty) {
      alerts.ifErrors("Password fields is required");
      return;
    } else if (email.text.trim().isNotEmpty &&
        password.text.trim().isNotEmpty) {
      Loader.startLoading();
      try {
        await repo.signInUsingEmail(email.text.trim(), password.text.trim());

        Loader.stopLoading();
        Navigator.pushAndRemoveUntil(
          navigator!.context,
          naviToAnotherPage(DashboardWidgets()),
          (route) => false,
        );
        cleanUi();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        Loader.stopLoading();
        print(
          "FirebaseAuthException Code: '${e.code}' | Message: ${e.message}",
        );
        alerts.ifErrors(mapFirebaseAuthErrors(e.code));
      } catch (e) {
        Loader.stopLoading();
        print("sign in issue $e");
        alerts.ifErrors("Something went wrong.");
      } finally {
        Loader.stopLoading();
      }
    }
  }

  String mapFirebaseAuthErrors(String code) {
    switch (code) {
      case 'user-not-found':
        return "There's No User With This Email";
      case 'wrong-password':
        return "Please Enter The Right Password";
      case 'invalid-email':
        return "Please Enter The Right Email";
      case 'invalid-credential':
        return "Invalid Email or Password";
      case 'user-disabled':
        return "This Email has Restricted";
      case 'too-many-requests':
        return "Too many attempts. Please try again later";
      case 'network-request-failed':
        return "Network error. Please check your connection";
      default:
        return 'Sign-in failed. Please try again.';
    }
  }

  void cleanUi() {
    email.clear();
    password.clear();
  }
}
