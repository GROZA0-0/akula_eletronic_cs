import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/staff_permissions_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/staff_permissions_model.dart';

class StaffPermissionsDataSourceImplementer
    implements StaffPermissionsDataSourceRepo {
  final Dio dio;
  StaffPermissionsDataSourceImplementer({required this.dio});

  @override
  Future<void> saveStaffPermissionDataSrouceRepo(
    bool pinRequired,
    String pinHash,

    Map<String, List<String>> hasAccess,
  ) async {
    final storeActions = '${Env.baseURL}saveStaffPermissionsRoute';
    final data = {
      'pinRequired': pinRequired,
      'pinHash': pinHash,

      'hasAccess': hasAccess,
    };
    final res = await dio.post(
      storeActions,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    // print('Raw response: ${res.data}');
    if (res.statusCode != 201 || res.statusCode != 200) {
      if (res.data == null) {
        StaffPermissionsModel.emptyStaffPermissionsModel();
      } else {
        final data = res.data['data'];
        StaffPermissionsModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating staff actions ? : ${res.statusCode}",
      );
    }
  }

  @override
  Future<StaffPermissionsModel> getStaffPermissionsDataSourceRepo() async {
    final getActions = '${Env.baseURL}getStaffPermissionsRoute';
    final res = await dio.get(
      getActions,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final rawData = res.data is Map ? res.data['data'] : res.data;
      return StaffPermissionsModel.fromJson(rawData);
    } else {
      throw Exception(
        "Any issue with fetching staff actions ? : ${res.statusCode}",
      );
    }
  }
}
