import 'package:dio/dio.dart';
import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/employee_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/model/employee_info_model.dart';

class EmployeeInfoDataSourceImplementer implements EmployeeInfoDataSourceRepo {
  final Dio dio;
  EmployeeInfoDataSourceImplementer({required this.dio});
  @override
  Future<EmployeeInfoModel> toEmployeeInfoRepository(String id) async {
    final getInfo = '${Env.baseURL}getEmployeeInfoRoute/$id';
    final res = await dio.get(getInfo);

    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return EmployeeInfoModel.empdataEmpty();
      } else {
        final jsonData = res.data;
        return EmployeeInfoModel.fromEmpSnapShot(jsonData);
      }
    } else {
      throw Exception(
        "Any issue with fetching profile info  Server Error: ${res.statusCode}",
      );
    }
  }

  @override
  Future<EmployeeInfoModel> toEmployeeStatusDataSourceRepository(
    String id,
    UserAccountStatus status,
  ) async {
    final patchInfo = '${Env.baseURL}changeStaffStatusRoute/$id';
    final data = {'empStatus': status.name};
    final res = await dio.patch(
      patchInfo,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    /* print("print user $id");
    print('what user status selected ${status.name}'); */
    if (res.statusCode == 201 || res.statusCode == 200) {
      if (res.data == null) {
        return EmployeeInfoModel.empdataEmpty();
      } else {
        final data = res.data['data'];
        return EmployeeInfoModel.fromEmpSnapShot(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching user status Error: ${res.statusCode}",
      );
    }
  }
}
