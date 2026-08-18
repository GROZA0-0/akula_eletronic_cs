import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_in_page.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_out_controller.dart';
import 'package:storecs/features/dash_board/presentation/pages/dash_board_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Timer? wearningTimer;
  Timer? signoutTimer;

  void startInactivityAcc() {
    cancelInactivityTimer();
    /* set auto signout with a duration */
    wearningTimer = Timer(Duration(minutes: 5), onInactivityWearing);
  }

  /* cancel the time */
  void cancelInactivityTimer() {
    wearningTimer?.cancel();
    signoutTimer?.cancel();
    wearningTimer = null;
    signoutTimer = null;
  }

  void onInactivityWearing() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    signoutTimer = Timer(const Duration(minutes: 10), signOut);
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: steelColor,
          title: Text("Inactivity Warning", style: textBodiesStyle),
          content: Text(
            "You have been inactive for 5 minutes. You will be automatically signed out in 10 minutes unless you continue.",
            style: textBodiesStyle,
          ),
          actions: [
            Center(
              child: Container(
                width: size.width / 3,
                decoration: BoxDecoration(
                  color: greenColor,
                  border: Border.all(color: white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  onTap: () {
                    if (Get.isDialogOpen ?? false) {
                      Navigator.pop(context);
                    }
                    startInactivityAcc(); /* Reset timers */
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Stay Signed In', style: textBodiesStyle),
                      Icon(Iconsax.login, color: white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future<void> signOut() async {
    cancelInactivityTimer();
    if (Get.isDialogOpen ?? false) {
      Navigator.pop(context);
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Inactivity limit reached. Auto signing out...');
      if (Get.isRegistered<SignOutController>()) {
        await Get.find<SignOutController>().signOutTrigger();
      } else {
        await FirebaseAuth.instance.signOut();
      }
    }
  }

  @override
  void dispose() {
    cancelInactivityTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: LoadingAnimationWidget.beat(color: white, size: 55),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          print('User logged in: ${snapshot.data?.email}');
          /* Acive the time to reset */
          if (wearningTimer == null || !wearningTimer!.isActive) {
            startInactivityAcc();
          }
          return MouseRegion(
            onHover: (_) => startInactivityAcc(),
            onEnter: (_) => startInactivityAcc(),
            child: Listener(
              behavior: HitTestBehavior.translucent,
              onPointerDown: (event) => startInactivityAcc(),
              onPointerMove: (event) => startInactivityAcc(),
              child: GradientBackground(child: DashBoardPage()),
            ),
          );
        }
        cancelInactivityTimer();
        print('No user logged in');
        return const GradientBackground(child: SignInPage());
      },
    );
  }
}
