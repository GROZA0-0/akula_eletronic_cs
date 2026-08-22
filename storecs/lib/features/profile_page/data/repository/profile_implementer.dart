import 'package:storecs/features/profile_page/data/data_source/profile_data_source_repository/profile_data_source_repository.dart';
import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';
import 'package:storecs/features/profile_page/domain/repository/profile_repository.dart';

class ProfileImplementer implements ProfileRepository {
  final ProfileDataSourceRepository dataSourceRepository;
  ProfileImplementer(this.dataSourceRepository);

  @override
  Future<ProfileEntities> getProfileRepo(String id) async {
    try {
      final model = await dataSourceRepository.getUserProfileInfo(id);
      return model.toProfileEntities();
    } catch (e) {
      print("any errors in ProfileImplementer $e");
      throw e.toString();
    }
  }
}
