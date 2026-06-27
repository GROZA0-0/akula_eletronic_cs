import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/staff_list/data/data_source/data_source_repo/staff_list_data_source_repo.dart';
import 'package:storecs/features/staff_list/data/model/staff_list_model.dart';

class StaffListDataSourceImplementer implements StaffListDataSourceRepo {
  final Dio dio;
  StaffListDataSourceImplementer({required this.dio});
  @override
  Future<StaffListModel> toStaffListRepository() async {
    final getStaff = '${Env.baseURL}getStaffListRoute';
    final res = await dio.get(getStaff);
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return StaffListModel.empEmptyInfo();
      } else {
        final data = res.data;
        return StaffListModel.fromBackEnd(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching staff list Server Error: ${res.statusCode}",
      );
    }
  }
}
