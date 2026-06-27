import 'package:storecs/features/staff_list/data/model/staff_list_model.dart';

abstract class StaffListDataSourceRepo {
  Future<StaffListModel> toStaffListRepository();
}
