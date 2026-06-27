import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

abstract class EmployeeInfoRepo {
  Future<EmployeeInfoEntities> toEmployeeInfoRepo(String id);
}
