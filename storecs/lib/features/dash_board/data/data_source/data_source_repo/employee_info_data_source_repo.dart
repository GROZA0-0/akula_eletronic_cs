import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/data/model/employee_info_model.dart';

abstract class EmployeeInfoDataSourceRepo {
  Future<EmployeeInfoModel> toEmployeeInfoRepository(String id);
  Future<EmployeeInfoModel> toEmployeeStatusDataSourceRepository(
    String id,
    UserAccountStatus status,
  );
}
