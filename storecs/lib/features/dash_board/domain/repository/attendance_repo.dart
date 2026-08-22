import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/domain/entities/attendance_entities.dart';

abstract class AttendanceRepo {
  Future<AttendanceEntities> storeAttDRepo(
    String empEmail,
    UserAccountStatus status,
  );
}
