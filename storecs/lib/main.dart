import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:storecs/Core/config/windows_manager.dart';
import 'package:storecs/features/pos_page/presentation/widgets/customer_display_widgets.dart';
import 'package:storecs/features/splash/splash_screen.dart';
import 'package:window_manager/window_manager.dart';
import 'Core/config/firebase_options.dart';
import 'package:storecs/Core/config/Bindings.dart';
import 'package:get/get.dart';

final GlobalKey<ScaffoldMessengerState> messengerKey =
    GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (args.firstOrNull == 'multi_window') {
    // Extract window arguments passed during creation
    final windowId = int.parse(args[1]);
    final windowShow = WindowController.fromWindowId(windowId);

    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: GradientBackground(
          child: CustomerDisplayApp(windowController: windowShow),
        ),
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await windowManager.ensureInitialized();
    final windowOptions = WindowsScreenManager().options;
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: messengerKey,

      initialRoute: '/splash',

      home: GradientBackground(child: SplashScreen()),

      getPages: [
        GetPage(
          name: '/splash',

          page: () => GradientBackground(child: SplashScreen()),

          binding: AppBindingsControllers(),
        ),
      ],

      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),

      debugShowCheckedModeBanner: false,
    );
  }
}
