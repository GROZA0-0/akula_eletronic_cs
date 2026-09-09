import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:storecs/Core/Styles/Strings.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/main.dart';

class SignUpController extends ChangeNotifier {
  final AuthRepo repository = sl<AuthRepo>();
  final AuthDataSource source = sl<AuthDataSource>();

  SignUpController(/* this.repository, this.source */);

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController level = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);
  bool whenLoading = false;
  String imageFileUrl = '';
  final ImagePicker picker = ImagePicker();
  File? selectedFile;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String selectedlevel = '';
  bool passVisible = true;
  List<String> staffLevels = [
    "Manager",
    "Team Leader",
    "Supervisor",
    "Q/A",
    "Cashier",
    "Sales",
    "HR",
    "Accountant",
    "IT",
    "Warehouse keeper",
  ];

  void changeLevel(String level) {
    selectedlevel = level;
    notifyListeners();
  }

  get newId => auth.currentUser?.uid ?? '';

  Future<void> uploadPic() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      selectedFile = File(file.path);
      notifyListeners();
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
    } else if (selectedlevel.isEmpty) {
      alerts.ifErrors(LevelIsRequire);
    } else if (selectedFile == null) {
      alerts.ifErrors('Product Picture is require');
    } else {
      Loader.startLoading();
      try {
        String base64Image = "";
        if (selectedFile != null && await selectedFile!.exists()) {
          final List<int> imageBytes = await selectedFile!.readAsBytes();
          base64Image = base64Encode(imageBytes);
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
            selectedlevel,
          );
          imageFileUrl = newEmp.empPic;
          alerts.ifSuccess(EmployeeCreated);
          clearUi();
          notifyListeners();
        }
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
    selectedFile = null;
    staffLevels = [];
  }
}
