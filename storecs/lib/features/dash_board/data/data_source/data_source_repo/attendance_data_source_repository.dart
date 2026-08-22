import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/data/model/attendance_model.dart';

abstract class AttendanceDataSourceRepository {
  Future<AttendanceModel> storeAttDataSourceRepo(
    String empEmail,
    UserAccountStatus status,
  );
}
