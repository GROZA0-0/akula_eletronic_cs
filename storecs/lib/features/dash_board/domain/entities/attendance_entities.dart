import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

class AttendanceEntities extends Equatable {
  final String empEmail;
  final DateTime? attendanceStart;
  final DateTime? clockOutTime;
  final String attendanceDuration;
  final UserAccountStatus status;
  const AttendanceEntities({
    required this.empEmail,
    required this.attendanceStart,
    required this.clockOutTime,
    required this.attendanceDuration,
    required this.status,
  });
  @override
  List<Object?> get props => [
    empEmail,
    attendanceStart,
    clockOutTime,
    attendanceDuration,
    status,
  ];
}
