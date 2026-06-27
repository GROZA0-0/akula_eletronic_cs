import 'package:firebase_auth/firebase_auth.dart';
import 'package:storecs/features/auth/domain/entities/employee_entities.dart';
import 'package:storecs/features/auth/data/data_source/data_implementer/employee_data_source_implementer.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';

class AuthImplement implements AuthRepo {
  final AuthDataSource authDataSource;
  final EmployeeInfoDataSourceImplemter employeeInfoDataSource;
  const AuthImplement({
    required this.authDataSource,
    required this.employeeInfoDataSource,
  });

  @override
  Future<EmployeeSignInEntities> signInUsingEmail(
    String email,
    String password,
  ) async {
    try {
      final credential = await authDataSource.signInWithEmail(email, password);
      return EmployeeSignInEntities(
        id: credential.user!.uid,
        email: credential.user!.email!,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Authentication sign in failed";
    }
  }

  @override
  Future<EmployeesCreatingAccountEntities> signUpUsingEmpEmail(
    String id,
    String idToken,
    String email,
    String password,
    String name,
    String phone,
    String pic,
    String level,
  ) async {
    try {
      final data = await employeeInfoDataSource.toCreateAccAuthDataSoruce(
        id,
        idToken,
        email,
        password,
        name,
        phone,
        pic,
        level,
      );
      return data.toEmployeeCreatingAccountEntities();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Authentication sign up failed";
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authDataSource.signOutFromCurrentUser();
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Authentication sign out failed";
    }
  }
}
