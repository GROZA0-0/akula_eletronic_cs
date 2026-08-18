import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';
import 'package:storecs/features/profile_page/domain/repository/profile_repository.dart';

class ProfileController {
  final ProfileRepository repository;
  ProfileController({required this.repository});

  ProfileEntities entities = const ProfileEntities(
    id: '',
    email: '',
    name: '',
    level: '',
    picture: '',
  );

  Future<ProfileEntities> getUserProfileInfo(String id) async {
    try {
      final getProfile = await repository.getProfileRepo(id);
      entities = getProfile;
      return getProfile;
    } catch (e) {
      print("error in profiles controller $e");
      throw e.toString();
    }
  }
}
