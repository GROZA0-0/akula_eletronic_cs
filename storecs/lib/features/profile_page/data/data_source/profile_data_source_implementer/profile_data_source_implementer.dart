import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/profile_page/data/data_source/profile_data_source_repository/profile_data_source_repository.dart';
import 'package:storecs/features/profile_page/data/model/profile_model.dart';

class ProfileDataSourceImplementer implements ProfileDataSourceRepository {
  final Dio dio;
  ProfileDataSourceImplementer({required this.dio});

  @override
  Future<ProfileModel> getUserProfileInfo(String id) async {
    final getProfile = '${Env.baseURL}getEmployeeInfoRoute/$id';
    final res = await dio.get(getProfile);
    if (res.statusCode == 200) {
      if (res.data == null) {
        return ProfileModel.emptyProfileInfo();
      } else {
        final data = res.data;
        return ProfileModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching profile info  Server Error: ${res.statusCode}",
      );
    }
  }
}
