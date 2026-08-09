import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

class EmployeeInfoEntities extends Equatable {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String userPic;
  final String level;
  final UserAccountStatus status;
  const EmployeeInfoEntities({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.userPic,
    required this.level,
    this.status = UserAccountStatus.offline,
  });

  @override
  List<Object?> get props => [id, email, name, phone, userPic, level, status];
}
