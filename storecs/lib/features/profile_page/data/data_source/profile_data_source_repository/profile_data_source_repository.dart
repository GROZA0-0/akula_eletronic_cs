import 'package:storecs/features/profile_page/data/model/profile_model.dart';

abstract class ProfileDataSourceRepository {
  Future<ProfileModel> getUserProfileInfo(String id);
}
