
import 'package:storecs/features/auth/domain/entities/employee_entities.dart';

abstract class AuthRepo {
  Future<EmployeeSignInEntities> signInUsingEmail(
    String email,
    String password,
  );

  Future<EmployeesCreatingAccountEntities> signUpUsingEmpEmail(
    String id,
    String idToken,
    String email,
    String password,
    String name,
    String phone,
    String pic,
    String level,
  );

  Future<void> signOut();
}
