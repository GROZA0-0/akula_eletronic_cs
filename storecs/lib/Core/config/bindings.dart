import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:storecs/features/auth/data/data_source/data_implementer/employee_data_source_implementer.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source.dart';
import 'package:storecs/features/auth/data/repository/employee_repository.dart';
import 'package:storecs/features/auth/domain/repository/employee_repo.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_in_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_out_controller.dart';
import 'package:storecs/features/auth/presentation/state_management/sign_up_controller.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_implementer/attendance_data_source_implementer.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_implementer/category_dashboard_data_source_implementer.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_implementer/employee_info_data_source_implementer.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_implementer/review_info_data_source_implementer.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/attendance_data_source_repository.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/category_dashboard_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/employee_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/review_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/repository/attendance_implementer.dart';
import 'package:storecs/features/dash_board/data/repository/category_dashboard_implementer.dart';
import 'package:storecs/features/dash_board/data/repository/employee_info_repository.dart';
import 'package:storecs/features/dash_board/data/repository/review_implementer.dart';
import 'package:storecs/features/dash_board/domain/repository/attendance_repo.dart';
import 'package:storecs/features/dash_board/domain/repository/category_dashboard_repo.dart';
import 'package:storecs/features/dash_board/domain/repository/employee_info_repo.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';
import 'package:storecs/features/dash_board/presentation/state_management/change_status_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_category_dashboard_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_reviews_info_dash_board_controller.dart';
import 'package:storecs/features/feedback_page/data/data_source/feedback_data_source_implementer/feedback_data_source_implementer.dart';
import 'package:storecs/features/feedback_page/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/feedback_page/data/repository/get_Feedback_implementer.dart';
import 'package:storecs/features/feedback_page/domain/repository/get_feedback_repo.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_controller.dart';
import 'package:storecs/features/issues_or_suggestions/data/data_source/feedback_data_source_implementer/feedback_data_source_implementer.dart';
import 'package:storecs/features/issues_or_suggestions/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/issues_or_suggestions/data/repository/feedback_implementer.dart';
import 'package:storecs/features/issues_or_suggestions/domain/repository/feedback_repository.dart';
import 'package:storecs/features/issues_or_suggestions/presentation/state_management/feedback_controller.dart';
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
import 'package:storecs/features/profile_page/data/data_source/profile_data_source_implementer/profile_data_source_implementer.dart';
import 'package:storecs/features/profile_page/data/data_source/profile_data_source_repository/profile_data_source_repository.dart';
import 'package:storecs/features/profile_page/data/repository/profile_implementer.dart';
import 'package:storecs/features/profile_page/domain/repository/profile_repository.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_controller.dart';
import 'package:storecs/features/report_page/data/data_source/report_data_source_implementer/report_data_source_implementer.dart';
import 'package:storecs/features/report_page/data/data_source/report_data_source_repository/report_data_source_repository.dart';
import 'package:storecs/features/report_page/data/repository/report_implementer.dart';
import 'package:storecs/features/report_page/domain/repository/report_repository.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_implementer/get_order_details_data_source_implementer.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_implementer/store_return_and_refund_info_data_source_implementer.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/get_order_details_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/store_return_and_refund_info_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/repository/order_details_repo_implementer.dart';
import 'package:storecs/features/returns&refunds/data/repository/store_return_and_refund_info_implementer.dart';
import 'package:storecs/features/returns&refunds/domain/repository/order_details_repo.dart';
import 'package:storecs/features/returns&refunds/domain/repository/store_return_and_refund_info_repository.dart';
import 'package:storecs/features/returns&refunds/presentation/state_management/return_and_refund_controller.dart';
import 'package:storecs/features/sales_export/data/data_source/export_reports_data_source_implmeneter/export_reports_data_source_implementer.dart';
import 'package:storecs/features/sales_export/data/data_source/export_reports_data_source_repo/export_reports_data_source_repo.dart';
import 'package:storecs/features/sales_export/data/repository/export_reports_implementer.dart';
import 'package:storecs/features/sales_export/domain/repository/export_reports_repo.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_implementer/product_matrix_data_source_implementer.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_implementer/tax_rules_data_source_implementer.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/product_matrix_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/tax_rules_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/repository/product_matrix_implementer.dart';
import 'package:storecs/features/settings_page/data/repository/tax_rules_implementer.dart';
import 'package:storecs/features/settings_page/domain/repository/product_matrix_repository.dart';
import 'package:storecs/features/settings_page/domain/repository/tax_rules_repository.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_controller.dart';
import 'package:storecs/features/settings_page/presentation/state_management/tax_rules_controller.dart';
import 'package:storecs/features/staff_list/data/data_source/data_source_implementer/staff_list_data_source_implementer.dart';
import 'package:storecs/features/staff_list/data/data_source/data_source_repo/staff_list_data_source_repo.dart';
import 'package:storecs/features/staff_list/data/repository/staff_list_repository.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';

class AppBindingsControllers extends Bindings {
  @override
  void dependencies() {
    final sl = GetIt.instance;

    final dio = Dio(); //----> network client

    sl.registerFactory<Dio>(() => dio);

    //////////////////////////////////////////////////////////
    sl.registerFactory<AuthDataSource>(() => AuthDataSource());

    sl.registerFactory<EmployeeInfoDataSourceImplemter>(
      () => EmployeeInfoDataSourceImplemter(client: dio),
    );
    sl.registerFactory<AuthRepo>(
      () => AuthImplement(
        authDataSource: sl<AuthDataSource>(),
        employeeInfoDataSource: sl<EmployeeInfoDataSourceImplemter>(),
      ),
    );
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////

    sl.registerFactory<EmployeeInfoDataSourceRepo>(
      () => EmployeeInfoDataSourceImplementer(dio: dio),
      /*  fenix: true, */
    );
    sl.registerFactory<EmployeeInfoRepo>(
      () => EmployeeInfoImplement(dataSource: sl<EmployeeInfoDataSourceRepo>()),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<StaffListDataSourceRepo>(
      () => StaffListDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<StaffListRepo>(
      () => StaffListRepository(repo: sl<StaffListDataSourceRepo>()),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<ProductListDataSourceRepo>(
      () => ProductListDataSourceImplementer(client: dio),
    );
    sl.registerFactory<ProductListRepo>(
      () =>
          ProductListImplementer(implementer: sl<ProductListDataSourceRepo>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<PosDataSourceRepo>(
      () => PosDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<PosRepo>(
      () => PosRepository(repo: sl<PosDataSourceRepo>()),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<ListOfItemsPurchasedDataSourceRepo>(
      () => ListOfItemsPurchasedDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ListOfItemsPurchasedRepo>(
      () => ListOfItemsPurchasedRepository(
        implementer: sl<ListOfItemsPurchasedDataSourceRepo>(),
      ),
    );

    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<GetOrderDetailsDataSourceRepository>(
      () => GetOrderDetailsDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<OrderDetailsRepo>(
      () => OrderDetailsRepoImplementer(
        repository: sl<GetOrderDetailsDataSourceRepository>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<OrderPurchasedHistoryDataSourceRepo>(
      () => OrderPurchasedHistoryDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<OrderPurchasedHistoryRepo>(
      () => OrderPurchasedHistoryImplementer(
        sourceRepo: sl<OrderPurchasedHistoryDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<StoreReturnAndRefundInfoDataSourceRepository>(
      () => StoreReturnAndRefundInfoDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<StoreReturnAndRefundInfoRepository>(
      () => StoreReturnAndRefundInfoImplementer(
        repository: sl<StoreReturnAndRefundInfoDataSourceRepository>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<ReportDataSourceRepository>(
      () => ReportDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ReportRepository>(
      () => ReportImplementer(
        reportDataSourceRepository: sl<ReportDataSourceRepository>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<ReviewInfoDataSourceRepo>(
      () => ReviewInfoDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ReviewRepo>(
      () => ReviewImplementer(
        reviewInfoDataSourceRepo: sl<ReviewInfoDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<CategoryDashboardDataSourceRepo>(
      () => CategoryDashboardDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<CategoryDashboardRepo>(
      () => CategoryDashboardImplementer(
        sourceRepo: sl<CategoryDashboardDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<FeedbackDataSourceRepo>(
      () => FeedbackDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<FeedbackRepository>(
      () => FeedbackImplementer(sl<FeedbackDataSourceRepo>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<GetFeedbackDataSourceRepo>(
      () => GetFeedbackDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<GetFeedbackRepo>(
      () => GetFeedbackImplementer(sourceRepo: sl<GetFeedbackDataSourceRepo>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<ExportReportsDataSourceRepo>(
      () => ExportReportsDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ExportReportsRepo>(
      () => ExportReportsImplementer(
        reportsDataSourceRepo: sl<ExportReportsDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<ProfileDataSourceRepository>(
      () => ProfileDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ProfileRepository>(
      () => ProfileImplementer(sl<ProfileDataSourceRepository>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<AttendanceDataSourceRepository>(
      () => AttendanceDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<AttendanceRepo>(
      () => AttendanceImplementer(sl<AttendanceDataSourceRepository>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<TaxRulesDataSourceRepo>(
      () => TaxRulesDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<TaxRulesRepository>(
      () => TaxRulesImplementer(sl<TaxRulesDataSourceRepo>()),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    sl.registerFactory<ProductMatrixDataSourceRepo>(
      () => ProductMatrixDataSourceImplementer(dio: dio),
    );
    sl.registerFactory<ProductMatrixRepository>(
      () => ProductMatrixImplementer(
        dataSourceRepo: sl<ProductMatrixDataSourceRepo>(),
      ),
    );
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////

    sl.registerFactory<SignInController>(
      () => SignInController(sl<AuthRepo>()),
    );
    sl.registerFactory<SignUpController>(() => SignUpController());
    sl.registerFactory<SignOutController>(
      () => SignOutController(sl<AuthRepo>(), sl<EmployeeInfoRepo>()),
    );
    sl.registerFactory<FetchEmployeeInfoDashBoardController>(
      () => FetchEmployeeInfoDashBoardController(
        repository: sl<EmployeeInfoRepo>(),
      ),
    );
    sl.registerFactory<StaffListController>(
      () => StaffListController(repository: sl<StaffListRepo>()),
    );
    sl.registerFactory<ProductListController>(
      () => ProductListController(sl<ProductListRepo>()),
    );
    sl.registerFactory<PosController>(() => PosController(repo: sl<PosRepo>()));
    sl.registerFactory<CartController>(
      () => CartController(repo: sl<ListOfItemsPurchasedRepo>()),
    );
    sl.registerFactory<OrderPurchasedHistoryController>(
      () => OrderPurchasedHistoryController(
        repo: sl<OrderPurchasedHistoryRepo>(),
      ),
    );
    sl.registerFactory<ReturnAndRefundController>(
      () => ReturnAndRefundController(
        repo: sl<OrderDetailsRepo>(),
        refundRepo: sl<StoreReturnAndRefundInfoRepository>(),
      ),
    );
    sl.registerFactory<ReportController>(
      () => ReportController(repository: sl<ReportRepository>()),
    );
    sl.registerFactory(
      () => FetchReviewsInfoDashBoardController(repo: sl<ReviewRepo>()),
    );
    sl.registerFactory<FetchCategoryDashboardController>(
      () => FetchCategoryDashboardController(repo: sl<CategoryDashboardRepo>()),
    );
    sl.registerFactory<FeedbackController>(
      () => FeedbackController(repository: sl<FeedbackRepository>()),
    );
    sl.registerFactory<GetFeedbackController>(
      () => GetFeedbackController(repo: sl<GetFeedbackRepo>()),
    );
    sl.registerFactory<ProfileController>(
      () => ProfileController(repository: sl<ProfileRepository>()),
    );
    sl.registerFactory<ChangeStatusController>(
      () => ChangeStatusController(sl<AttendanceRepo>()),
    );
    sl.registerFactory<TaxRulesController>(
      () => TaxRulesController(sl<TaxRulesRepository>()),
    );
    sl.registerFactory<ProductMatrixController>(
      () => ProductMatrixController(sl<ProductMatrixRepository>()),
    );
  }
}
