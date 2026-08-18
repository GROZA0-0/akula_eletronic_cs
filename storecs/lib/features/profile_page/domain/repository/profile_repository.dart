import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';

abstract class ProfileRepository {
  Future<ProfileEntities> getProfileRepo(String id);
}
