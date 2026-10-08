import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';

abstract class StaffListRepo {
  Future<List<StaffListEntities>> toStaffListdomainRepo();
  Future<StaffListEntities> toUpdateStaffRepository(
    String id,
    String phone,
    String field,
    UserAccountStatus status,
  );
  Future<StaffListEntities> toTerminateStaffAccountRepository(String id);
}
