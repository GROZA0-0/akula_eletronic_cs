import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

class StaffListEntities extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String pic;
  final String level;
  final UserAccountStatus empStatus;

  const StaffListEntities({
    required this.id,
    required this.name,
    required this.phone,
    required this.pic,
    required this.level,
    this.empStatus = UserAccountStatus.offline,
  });

  @override
  List<Object?> get props => [id, name, phone, pic, level, empStatus];
}
