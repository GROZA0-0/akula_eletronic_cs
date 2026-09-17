import 'package:storecs/features/settings_page/data/data_source/data_source_repo/staff_permissions_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/staff_permissions_entities.dart';

import 'package:storecs/features/settings_page/domain/repository/staff_permissions_repository.dart';

class StaffPermissionsImplementer implements StaffPermissionsRepository {
  final StaffPermissionsDataSourceRepo repo;
  StaffPermissionsImplementer({required this.repo});
  @override
  Future<void> saveStaffPermissionRepositoy(
    bool pinRequired,
    String pinHash,

    Map<String, List<String>> hasAccess,
  ) async {
    try {
      await repo.saveStaffPermissionDataSrouceRepo(
        pinRequired,
        pinHash,

        hasAccess,
      );
    } catch (e) {
      print("any errors in StaffPermissionsImplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<StaffPermissionsEntities> getStaffPermissionsRepo() async {
    try {
      final model = await repo.getStaffPermissionsDataSourceRepo();
      return model.toStaffPermissionsEntities();
    } catch (e) {
      print("any errors in StaffPermissionsImplementer $e");
      throw e.toString();
    }
  }
}
