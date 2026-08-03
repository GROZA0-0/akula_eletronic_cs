import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_in_page.dart';
import 'package:storecs/Core/Styles/Colors.dart';
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
  Timer? time;

  void startInactivityAcc() {
    cancelInactivityTimer();
    /* set auto signout with a duration */
    time = Timer(Duration(minutes: 10), signOut);
  }

  /* cancel the time */
  void cancelInactivityTimer() {
    time?.cancel();
    time = null;
  }

  /*  */
  Future<void> signOut() async {
    cancelInactivityTimer();
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
          if (time == null || !time!.isActive) {
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
