import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';

class ProfileModel {
  final String id;
  final String email;
  final String name;
  final String level;
  final UserAccountStatus status;
  final String picture;

  ProfileModel({
    required this.id,
    required this.email,
    required this.name,
    required this.level,
    required this.picture,
    this.status = UserAccountStatus.offline,
  });

  static ProfileModel emptyProfileInfo() {
    return ProfileModel(
      id: '',
      email: '',
      name: '',
      level: '',
      picture: '',
      status: UserAccountStatus.offline,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['_id'],
      email: map['empEmail'] ?? '',
      name: map['empName'] ?? '',
      level: map['empLvl'] ?? '',
      picture: map['empPic'] ?? '',
      status: UserAccountStatus.values.firstWhere(
        (element) => element.name == map['empStatus'],
        orElse: () => UserAccountStatus.offline,
      ),
    );
  }

  ProfileEntities toProfileEntities() {
    return ProfileEntities(
      id: id,
      email: email,
      name: name,
      level: level,
      picture: picture,
      status: status,
    );
  }
}
