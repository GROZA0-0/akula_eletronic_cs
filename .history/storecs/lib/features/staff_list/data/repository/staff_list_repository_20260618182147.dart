import 'package:storecs/features/staff_list/data/data_source/data_source_repo/staff_list_data_source_repo.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';

class StaffListRepository implements StaffListRepo {
  final StaffListDataSourceRepo repo;
  StaffListRepository(this.repo);
  @override
  Future<StaffListEntities> toStaffListdomainRepo() async {
    try {
      final model = await repo.toStaffListRepository();
      return model.toStaffListEntities();
    } catch (e) {
      print("any errors in EmployeeImplements $e");
      throw e.toString();
    }
  }
}
