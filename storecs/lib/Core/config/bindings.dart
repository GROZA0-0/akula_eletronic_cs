import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:dio/dio.dart';
import 'package:storecs/features/auth/data/data_source/data_implementer/employee_data_source_implementer.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source.dart';
import 'package:storecs/features/auth/data/repository/employee_repository.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_out_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_up_controller.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_implementer/employee_info_data_source_implementer.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/employee_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/repository/employee_info_repository.dart';
import 'package:storecs/features/dash_board/domain/repository/employee_info_repo.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/order_purchased_history/data/data_source/order_purchased_history_data_source_implementer/order_purchased_history_data_source_implementer.dart';
import 'package:storecs/features/order_purchased_history/data/data_source/order_purchased_history_data_source_repo/order_purchased_history_data_source_repo.dart';
import 'package:storecs/features/order_purchased_history/data/repository/order_purchased_history_implementer.dart';
import 'package:storecs/features/order_purchased_history/domain/repository/order_purchased_history_repo.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_controller.dart';
import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/list_of_items_purchased_data_source_repo.dart';
import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/pos_data_source_repo.dart';
import 'package:storecs/features/pos_page/data/data_source/data_source_implementer/list_of_items_purchased_data_source_implementer.dart';
import 'package:storecs/features/pos_page/data/data_source/data_source_implementer/pos_data_source_implementer.dart';
import 'package:storecs/features/pos_page/data/repository/list_of_items_purchased_repository.dart';
import 'package:storecs/features/pos_page/data/repository/pos_repository.dart';
import 'package:storecs/features/pos_page/domain/repository/list_of_items_purchased_repo.dart';
import 'package:storecs/features/pos_page/domain/repository/pos_repo.dart';
import 'package:storecs/features/pos_page/presentation/state_management/cart_controller.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_controller.dart';
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_implementer/product_list_Data_Source_implementer.dart';
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_repo/product_list_data_source_repo.dart';
import 'package:storecs/features/product_list/data/repository/product_list_implementer.dart';
import 'package:storecs/features/product_list/domain/repository/product_list_repo.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_controller.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_implementer/get_order_details_data_source_implementer.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_implementer/store_return_and_refund_info_data_source_implementer.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/get_order_details_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/store_return_and_refund_info_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/repository/order_details_repo_implementer.dart';
import 'package:storecs/features/returns&refunds/data/repository/store_return_and_refund_info_implementer.dart';
import 'package:storecs/features/returns&refunds/domain/repository/order_details_repo.dart';
import 'package:storecs/features/returns&refunds/domain/repository/store_return_and_refund_info_repository.dart';
import 'package:storecs/features/returns&refunds/presentation/state_management/return_and_refund_controller.dart';
import 'package:storecs/features/staff_list/data/data_source/data_source_implementer/staff_list_data_source_implementer.dart';
import 'package:storecs/features/staff_list/data/data_source/data_source_repo/staff_list_data_source_repo.dart';
import 'package:storecs/features/staff_list/data/repository/staff_list_repository.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';

class AppBindingsControllers extends Bindings {
  @override
  void dependencies() {
    final httpClient = https.Client(); //----> network client
    final dio = Dio(); //----> network client
    Get.lazyPut<https.Client>(() => httpClient);
    Get.lazyPut<Dio>(() => dio);

    //////////////////////////////////////////////////////////
    Get.lazyPut<AuthDataSource>(() => AuthDataSource());
    Get.lazyPut<EmployeeInfoDataSourceImplemter>(
      () => EmployeeInfoDataSourceImplemter(client: dio),
    );
    Get.put<AuthRepo>(
      AuthImplement(
        authDataSource: Get.find<AuthDataSource>(),
        employeeInfoDataSource: Get.find<EmployeeInfoDataSourceImplemter>(),
      ),
      permanent: true,
    );
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////

    Get.lazyPut<EmployeeInfoDataSourceRepo>(
      () => EmployeeInfoDataSourceImplementer(dio: Get.find<Dio>()),
      fenix: true,
    );
    Get.lazyPut<EmployeeInfoRepo>(
      () => EmployeeInfoImplement(
        dataSource: Get.find<EmployeeInfoDataSourceRepo>(),
      ),
      fenix: true,
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<StaffListDataSourceRepo>(
      () => StaffListDataSourceImplementer(dio: dio),
      fenix: true,
    );
    Get.lazyPut<StaffListRepo>(
      () => StaffListRepository(repo: Get.find<StaffListDataSourceRepo>()),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<ProductListDataSourceRepo>(
      () => ProductListDataSourceImplementer(client: dio),
    );
    Get.lazyPut<ProductListRepo>(
      () => ProductListImplementer(
        implementer: Get.find<ProductListDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<PosDataSourceRepo>(() => PosDataSourceImplementer(dio: dio));
    Get.lazyPut<PosRepo>(
      () => PosRepository(repo: Get.find<PosDataSourceRepo>()),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<ListOfItemsPurchasedDataSourceRepo>(
      () => ListOfItemsPurchasedDataSourceImplementer(dio: dio),
    );
    Get.lazyPut<ListOfItemsPurchasedRepo>(
      () => ListOfItemsPurchasedRepository(
        implementer: Get.find<ListOfItemsPurchasedDataSourceRepo>(),
      ),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<GetOrderDetailsDataSourceRepository>(
      () => GetOrderDetailsDataSourceImplementer(dio: dio),
    );
    Get.lazyPut<OrderDetailsRepo>(
      () => OrderDetailsRepoImplementer(
        repository: Get.find<GetOrderDetailsDataSourceRepository>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<OrderPurchasedHistoryDataSourceRepo>(
      () => OrderPurchasedHistoryDataSourceImplementer(dio: dio),
    );
    Get.lazyPut<OrderPurchasedHistoryRepo>(
      () => OrderPurchasedHistoryImplementer(
        sourceRepo: Get.find<OrderPurchasedHistoryDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<StoreReturnAndRefundInfoDataSourceRepository>(
      () => StoreReturnAndRefundInfoDataSourceImplementer(dio: dio),
    );
    Get.lazyPut<StoreReturnAndRefundInfoRepository>(
      () => StoreReturnAndRefundInfoImplementer(
        repository: Get.find<StoreReturnAndRefundInfoDataSourceRepository>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    Get.lazyPut<SignInController>(
      () => SignInController(Get.find<AuthRepo>()),
      fenix: true,
    );
    Get.lazyPut<SignUpController>(
      () => SignUpController(Get.find<AuthRepo>(), Get.find<AuthDataSource>()),
      fenix: true,
    );
    Get.lazyPut<SignOutController>(
      () => SignOutController(Get.find<AuthRepo>()),
      fenix: true,
    );
    Get.lazyPut<FetchEmployeeInfoDashBoardController>(
      () => FetchEmployeeInfoDashBoardController(
        repository: Get.find<EmployeeInfoRepo>(),
      ),
      fenix: false,
    );
    Get.put<StaffListController>(
      permanent: true,
      /* () => */ StaffListController(repository: Get.find<StaffListRepo>()),
    );
    Get.put<ProductListController>(
      permanent: true,
      ProductListController(Get.find<ProductListRepo>()),
    );
    Get.lazyPut<PosController>(() => PosController(repo: Get.find<PosRepo>()));
    Get.lazyPut<CartController>(
      () => CartController(repo: Get.find<ListOfItemsPurchasedRepo>()),
    );
    Get.lazyPut<OrderPurchasedHistoryController>(
      () => OrderPurchasedHistoryController(
        repo: Get.find<OrderPurchasedHistoryRepo>(),
      ),
    );
    Get.lazyPut<ReturnAndRefundController>(
      () => ReturnAndRefundController(
        repo: Get.find<OrderDetailsRepo>(),
        refundRepo: Get.find<StoreReturnAndRefundInfoRepository>(),
      ),
    );
  }
}
