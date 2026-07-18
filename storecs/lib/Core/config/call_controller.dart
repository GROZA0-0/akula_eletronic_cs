import 'package:get/get.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_out_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_up_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_controller.dart';
import 'package:storecs/features/pos_page/presentation/state_management/cart_controller.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_controller.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_controller.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';
import 'package:storecs/features/returns&refunds/presentation/state_management/return_and_refund_controller.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';

final signInController = Get.find<SignInController>();
final signUpController = Get.find<SignUpController>();
final signOutController = Get.find<SignOutController>();
final fetchEmployeeInfoDashBoardController =
    Get.find<FetchEmployeeInfoDashBoardController>();
final staffListController = Get.find<StaffListController>();
final productListController = Get.find<ProductListController>();
final posController = Get.find<PosController>();
final cartController = Get.find<CartController>();
final orderPurchasedHistoryController =
    Get.find<OrderPurchasedHistoryController>();
final returnAndRefundController = Get.find<ReturnAndRefundController>();
final reportController = Get.find<ReportController>();
