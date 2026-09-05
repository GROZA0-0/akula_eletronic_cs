import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

// ignore: must_be_immutable
class StaffListEntities extends Equatable {
  final String id;
  final String email;
  final String name;
  String? phone;
  final String pic;
  String? level;
  final UserAccountStatus empStatus;

  StaffListEntities({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    required this.pic,
    this.level,
    this.empStatus = UserAccountStatus.offline,
  });

  @override
  List<Object?> get props => [id, email, name, phone, pic, level, empStatus];
}
