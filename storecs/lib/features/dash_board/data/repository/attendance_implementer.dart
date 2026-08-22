import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/attendance_data_source_repository.dart';
import 'package:storecs/features/dash_board/domain/entities/attendance_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/attendance_repo.dart';

class AttendanceImplementer implements AttendanceRepo {
  final AttendanceDataSourceRepository sourceRepository;
  AttendanceImplementer(this.sourceRepository);

  @override
  Future<AttendanceEntities> storeAttDRepo(
    String empEmail,
    UserAccountStatus status,
  ) async {
    try {
      final model = await sourceRepository.storeAttDataSourceRepo(
        empEmail,
        status,
      );
      return model.toAttendanceEntities();
    } catch (e) {
      print("any errors in AttendanceImplementer $e");
      throw e.toString();
    }
  }
}
