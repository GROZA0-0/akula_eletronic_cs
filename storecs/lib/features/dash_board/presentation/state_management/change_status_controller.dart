import 'package:get/get.dart';
import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/domain/repository/attendance_repo.dart';

class ChangeStatusController {
  final AttendanceRepo repo;
  ChangeStatusController(this.repo);

  var currentStatus = UserAccountStatus.offline.obs;
  var isLoading = false;

  Future<void> changeStats(String empEmail, UserAccountStatus newStatus) async {
    try {
      isLoading = true;
      final result = await repo.storeAttDRepo(empEmail, newStatus);
      currentStatus.value = result.status;
    } catch (e) {
      print("error in change status controller $e");
    }
  }
}
