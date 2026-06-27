import 'package:get/get.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_out_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_up_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';

final signInController = Get.find<SignInController>();
final signUpController = Get.find<SignUpController>();
final signOutController = Get.find<SignOutController>();
final fetchEmployeeInfoDashBoardController =
    Get.find<FetchEmployeeInfoDashBoardController>();
final staffListController = Get.find<StaffListController>();
