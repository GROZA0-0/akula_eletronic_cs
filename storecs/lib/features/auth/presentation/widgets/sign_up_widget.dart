import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:remixicon/remixicon.dart';
import 'package:storecs/Core/Styles/Colors.dart';
import 'package:storecs/Core/Styles/Strings.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({super.key});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: Text("Add Employees (Sign Up)", style: textAppBar),
        iconTheme: IconThemeData(color: white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.008,
              vertical: size.height * 0.010,
            ),
            width: double.infinity,
            height: size.height / 0.80,
            decoration: BoxDecoration(
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SignUpTextFieldTemplate(
                  text: EmailTextField,
                  controller: signUpController.email,
                  passVisible: false,
                  icon: Icon(Icons.email_rounded, color: white),
                ),
                SignUpTextFieldTemplate(
                  text: PasswordTextField,
                  controller: signUpController.password,
                  passVisible: true,
                  icon: Icon(RemixIcons.lock_password_fill, color: white),
                ),
                SignUpTextFieldTemplate(
                  text: NameTextField,
                  controller: signUpController.name,
                  passVisible: false,
                  icon: Icon(RemixIcons.user_2_line, color: white),
                ),
                SignUpTextFieldTemplate(
                  text: LevelTextField,
                  controller: signUpController.level,
                  passVisible: false,
                  icon: Icon(FontAwesomeIcons.typo3, color: white),
                ),
                SignUpTextFieldTemplate(
                  text: PhoneTextField,
                  controller: signUpController.phone,
                  passVisible: false,
                  icon: Icon(FontAwesomeIcons.phone, color: white),
                ),
                sizeBoxHeight(size.height * 0.04),
                Obx(
                  () => InkWell(
                    onTap: () => signUpController.uploadPic(),
                    child: signUpController.selectedFile.value != null
                        ? CircleAvatar(
                            radius: 60,
                            foregroundImage: FileImage(
                              signUpController.selectedFile.value!,
                            ),
                          )
                        : Column(
                            children: [
                              Icon(
                                Iconsax.document_upload,
                                color: white,
                                size: 60,
                              ),

                              Text(
                                "Choose a profile picture.",
                                style: textAppBar,
                              ),
                            ],
                          ),
                  ),
                ),
                sizeBoxHeight(size.height * 0.09),
                InkWell(
                  onTap: () => signUpController.createEmployeeAccController(),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.05,
                    child: Center(
                      child: Text(
                        "Create an Account",
                        style: textStyleForButtons(24),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpTextFieldTemplate extends StatelessWidget {
  const SignUpTextFieldTemplate({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.passVisible,
  });
  final String text;
  final Icon icon;
  final TextEditingController controller;
  final bool passVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.020,
        vertical: size.height * 0.030,
      ),
      width: size.width / 1.2,
      height: size.height / 10,
      child: TextFormField(
        controller: controller,
        style: textBodiesStyle,
        obscureText: passVisible,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: greenColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
