import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/Styles/Colors.dart';

import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';

class SignInWidgets extends StatefulWidget {
  const SignInWidgets({super.key});

  @override
  State<SignInWidgets> createState() => _SignInWidgetsState();
}

class _SignInWidgetsState extends State<SignInWidgets> {
  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      signInController.email.clear();
      signInController.password.clear();
      signInController.isPassVisible = true;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: invisible,
      body: SafeArea(
        child: Container(
          margin: screenSize,
          child: SingleChildScrollView(
            child: Container(
              color: invisible,
              height: size.height,
              child: Center(child: SignInBody()),
            ),
          ),
        ),
      ),
    );
  }
}

class SignInBody extends StatefulWidget {
  const SignInBody({super.key});

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(child: Image.asset('assets/images/app_icon.ico')),
            ),
            Text(
              "Akula",
              style: GoogleFonts.pixelifySans(
                color: white,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            sizeBoxHeight(size.height * 0.05),
            emailTextField(),
            sizeBoxHeight(size.height * 0.05),
            passwordTextField(),
            sizeBoxHeight(size.height * 0.1),
            signbutton(),
          ],
        ),
      ],
    );
  }

  Container signbutton() {
    return Container(
      width: size.width * 0.3,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: ElevatedButton(
        onPressed: () => signInController.signInTrigger(),
        child: Text(
          "Continue",
          style: GoogleFonts.aleo(color: black, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Container passwordTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      width: size.width * 0.3,
      child: TextFormField(
        controller: signInController.password,
        obscureText: signInController.isPassVisible,
        onFieldSubmitted: (value) => signInController.signInTrigger(),
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontWeight: FontWeight.w400,
          ),
          suffixIcon: togglePassword(),
          prefixIcon: const Icon(Iconsax.lock_1, color: white),
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
            borderSide: const BorderSide(color: blueGreen, width: 2),
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

  Container emailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      width: size.width * 0.3,
      child: TextFormField(
        controller: signInController.email,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(Iconsax.user, color: white),
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
            borderSide: const BorderSide(color: blueGreen, width: 2),
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

  Widget togglePassword() {
    return GestureDetector(
      onTap: () => setState(() {
        signInController.isPassVisible = !signInController.isPassVisible;
      }),
      child: signInController.isPassVisible
          ? const Icon(Iconsax.eye_slash, color: white)
          : const Icon(Iconsax.eye, color: white),
    );
  }
}
