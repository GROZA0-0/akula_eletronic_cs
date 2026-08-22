import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/domain/entities/attendance_entities.dart';

class AttendanceModel {
  final String empEmail;
  final DateTime? attendanceStart;
  final DateTime? clockOutTime;
  final String attendanceDuration;
  final UserAccountStatus status;

  AttendanceModel({
    required this.empEmail,
    required this.attendanceStart,
    required this.clockOutTime,
    required this.attendanceDuration,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'empEmail': empEmail,
      'attendanceStart': attendanceStart?.toIso8601String(),
      'clockOutTime': clockOutTime?.toIso8601String(),
      'attendanceDuration': attendanceDuration,
      'status': status,
    };
  }

  static AttendanceModel emptyAttendanceModel() {
    return AttendanceModel(
      empEmail: '',
      attendanceStart: DateTime.now(),
      clockOutTime: DateTime.now(),
      attendanceDuration: '',
      status: UserAccountStatus.offline,
    );
  }

  factory AttendanceModel.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return AttendanceModel(
        empEmail: '',
        attendanceStart: DateTime.now(),
        clockOutTime: DateTime.now(),
        attendanceDuration: '',
        status: UserAccountStatus.offline,
      );
    }
    return AttendanceModel(
      empEmail: map['empEmail'] ?? '',
      attendanceStart: map['attendanceStart'] != null
          ? DateTime.tryParse(map['attendanceStart'])
          : null,
      clockOutTime: map['attendanceStart'] != null
          ? DateTime.tryParse(map['attendanceStart'])
          : null,
      attendanceDuration: map['attendanceDuration'] ?? '00:00:00',
      status: UserAccountStatus.values.firstWhere(
        (e) =>
            e.name == map['status'] ||
            e.toString().split('.').last == map['status'],
        orElse: () => UserAccountStatus.offline, // Default fallback
      ),
    );
  }
  AttendanceEntities toAttendanceEntities() {
    return AttendanceEntities(
      empEmail: empEmail,
      attendanceStart: attendanceStart,
      clockOutTime: clockOutTime,
      attendanceDuration: attendanceDuration,
      status: status,
    );
  }
}
