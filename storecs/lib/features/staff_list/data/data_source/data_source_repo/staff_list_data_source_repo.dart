import 'package:storecs/features/staff_list/data/model/staff_list_model.dart';

abstract class StaffListDataSourceRepo {
  Future<List<StaffListModel>> toStaffListRepository();
  Future<StaffListModel> toUpdateStaffDataSourceRepository(
    String id,
    String phone,
    String field,
  );
  Future<StaffListModel> toTerminateStaffAccountDataSourceRepository(String id);
}
