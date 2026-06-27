import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthDataSource {
  final user = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmail(String email, String password) async {
    return await user.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signUpWithEmail(String email, String password) async {
    return Future.microtask(() async {
      FirebaseApp? secondaryApp;
      try {
        secondaryApp = Firebase.apps.firstWhere(
          (app) => app.name == 'SecondaryApp',
          orElse: () => throw Exception('Not found'),
        );
      } catch (_) {
        secondaryApp = await Firebase.initializeApp(
          name: 'SecondaryApp',
          options: Firebase.app().options,
        );
      }

      try {
        FirebaseAuth secondAuth = FirebaseAuth.instanceFor(app: secondaryApp);
        final addEmp = await secondAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print('New account created: ${addEmp.user?.email}');
        print('New account ID: ${addEmp.user?.uid}');
        return addEmp;
      } finally {
        // ✅ Delete secondary app
        await secondaryApp.delete();
        print('✅ Secondary app deleted');
      }
    });
  }

  Future<void> signOutFromCurrentUser() async {
    return await user.signOut();
  }
}
