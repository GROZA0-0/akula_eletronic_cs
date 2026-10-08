import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/staff_list/data/model/staff_list_model.dart';

abstract class StaffListDataSourceRepo {
  Future<List<StaffListModel>> toStaffListRepository();
  Future<StaffListModel> toUpdateStaffDataSourceRepository(
    String id,
    String phone,
    String field,
    UserAccountStatus status,
  );
  Future<StaffListModel> toTerminateStaffAccountDataSourceRepository(String id);
}
