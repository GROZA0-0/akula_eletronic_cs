import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

class ProfileEntities extends Equatable {
  final String id;
  final String email;
  final String name;
  final String level;
  final UserAccountStatus status;
  final String picture;
  const ProfileEntities({
    required this.id,
    required this.email,
    required this.name,
    required this.level,
    required this.picture,
    this.status = UserAccountStatus.offline,
  });

  @override
  List<Object?> get props => [id, email, name, level, status, picture];
}
