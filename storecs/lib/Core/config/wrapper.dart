import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_in_page.dart';
import 'package:storecs/Core/Styles/Colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:storecs/features/dash_board/presentation/pages/dash_board_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

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
          return const GradientBackground(child: DashBoardPage());
        }

        print('No user logged in');
        return const GradientBackground(child: SignInPage());
      },
    );
  }
}
