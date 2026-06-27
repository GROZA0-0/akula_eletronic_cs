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

class SignInBody extends StatelessWidget {
  const SignInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sizeBoxHeight(size.height * 0.05),
        emailTextField(),
        sizeBoxHeight(size.height * 0.05),
        passwordTextField(),
        sizeBoxHeight(size.height * 0.1),
        signbutton(),
      ],
    );
  }

  Container signbutton() {
    return Container(
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      child: ElevatedButton(
        onPressed: ()  =>  signInController.signInTrigger(),
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
      child: TextFormField(
        controller: signInController.password,
        obscureText: true,
        // validator: validator,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontWeight: FontWeight.w400,
          ),
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

  Container emailTextField() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.025),
      child: TextFormField(
        controller: signInController.email,
        style: textBodiesStyle,
        // obscureText: passVisible,
        // validator: validator,
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
