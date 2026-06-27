
import 'package:storecs/features/auth/data/models/employee_model.dart';

abstract class EmpDataSoruce {
  Future<EmployeeModel> toCreateAccAuthDataSoruce(
    String id,
    String idToken,
    String email,
    String password,
    String name,
    String phone,
    String picture,
    String level,
  );
}
