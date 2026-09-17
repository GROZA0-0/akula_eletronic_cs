import 'package:storecs/features/settings_page/domain/entities/staff_permissions_entities.dart';

abstract class StaffPermissionsRepository {
  Future<void> saveStaffPermissionRepositoy(
    bool pinRequired,
    String pinHash,

    Map<String, List<String>> hasAccess,
  );
  Future<StaffPermissionsEntities> getStaffPermissionsRepo();
}
