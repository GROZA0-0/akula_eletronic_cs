import 'package:storecs/features/settings_page/data/model/staff_permissions_model.dart';

abstract class StaffPermissionsDataSourceRepo {
  Future<void> saveStaffPermissionDataSrouceRepo(
    bool pinRequired,
    String pinHash,

    Map<String, List<String>> hasAccess,
  );
  Future<StaffPermissionsModel> getStaffPermissionsDataSourceRepo();
}
