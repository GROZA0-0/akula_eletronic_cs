import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/config/wrapper.dart';
import 'package:storecs/Core/styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    Get.offAll(() => const Wrapper(), transition: Transition.fadeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset('assets/images/app_icon.ico'),
            ),
            const SizedBox(height: 24),
            Text(
              '''
          Akula
For Electronics
              ''',
              style: GoogleFonts.pixelifySans(
                color: white,
                fontSize: 27,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 40),
            LoadingAnimationWidget.beat(color: Colors.white70, size: 30),
          ],
        ),
      ),
    );
  }
}
