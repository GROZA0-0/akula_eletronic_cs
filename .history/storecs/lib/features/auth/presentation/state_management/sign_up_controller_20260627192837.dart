import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:storecs/Core/Styles/Strings.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/main.dart';

class SignUpController extends GetxController {
  final AuthRepo repository;
  final AuthDataSource source;
  SignUpController(this.repository, this.source);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController level = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);
  final Rx<File?> selectedFile = Rx<File?>(null);
  final RxBool whenLoading = false.obs;
  final RxString imageFileUrl = ''.obs;
  final ImagePicker picker = ImagePicker();
  final FirebaseAuth auth = FirebaseAuth.instance;

  get newId => auth.currentUser?.uid ?? '';

  Future<void> uploadPic() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      selectedFile.value = File(file.path);
    }
  }

  // building method of sign up page
  Future<void> createEmployeeAccController() async {
    if (email.text.trim().isEmpty) {
      alerts.ifErrors(EmailIsRequire);
    } else if (password.text.trim().isEmpty) {
      alerts.ifErrors(PasswordIsRequire);
    } else if (name.text.trim().isEmpty) {
      alerts.ifErrors(NameIsRequire);
    } else if (phone.text.trim().isEmpty) {
      alerts.ifErrors(PhoneIsRequire);
    } else if (level.text.trim().isEmpty) {
      alerts.ifErrors(LevelIsRequire);
    } else {
      Loader.startLoading();
      try {
        String base64Image = "";
        if (selectedFile.value != null && await selectedFile.value!.exists()) {
          final List<int> imageBytes = await selectedFile.value!.readAsBytes();
          base64Image = base64Encode(imageBytes);
        }
        await source.signUpWithEmail(email.text, password.text);
        final currentMgr = auth.currentUser;
        print('Manager still signed in: ${currentMgr?.email}');
        String newIdToken = await auth.currentUser?.getIdToken() ?? '';
        final newEmp = await repository.signUpUsingEmpEmail(
          newId,
          newIdToken,
          email.text.trim(),
          password.text.trim(),
          name.text.trim(),
          phone.text.trim(),
          base64Image,
          level.text.trim(),
        );
        imageFileUrl.value = newEmp.empPic;
        alerts.ifSuccess(EmployeeCreated);
      } on PlatformException catch (e) {
        print('The Error Is: ${e.message.toString()}');
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      } catch (e) {
        Loader.stopLoading();
        print("Something went wrong. $e");
        alerts.ifErrors("Something went wrong.");
      } finally {
        Loader.stopLoading();
      }
    }
  }

  void clearUi() {
    email.clear();
    password.clear();
    name.clear();
    phone.clear();
    level.clear();
    selectedFile.value == null;
  }
}
