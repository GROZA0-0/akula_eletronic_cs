import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:storecs/Core/config/windows_manager.dart';
import 'package:storecs/features/splash/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'Core/config/firebase_options.dart';
import 'package:storecs/Core/config/Bindings.dart';
import 'package:get/get.dart';

final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await windowManager.waitUntilReadyToShow(
    WindowsScreenManager().options,
    () async {
      await windowManager.show();
      await windowManager.focus();
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: messengerKey,
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => SplashScreen(),
          binding: AppBindingsControllers(),
        ),
      ],
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
      debugShowCheckedModeBanner: false,
    );
  }
}
