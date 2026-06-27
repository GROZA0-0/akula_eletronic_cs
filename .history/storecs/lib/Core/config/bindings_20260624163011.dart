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
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_implementer/product_list_Data_Source_implementer.dart';
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_repo/product_list_data_source_repo.dart';
import 'package:storecs/features/product_list/data/repository/product_list_implementer.dart';
import 'package:storecs/features/product_list/domain/repository/product_list_repo.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_controller.dart';
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

    // Get.put(() => Get.find<EmployeeInfoDataSourceImplementer>());

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
  }
}
