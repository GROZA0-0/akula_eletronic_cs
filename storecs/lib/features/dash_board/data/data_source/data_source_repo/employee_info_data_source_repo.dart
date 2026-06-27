import 'package:storecs/features/dash_board/data/model/employee_info_model.dart';

abstract class EmployeeInfoDataSourceRepo {
  Future<EmployeeInfoModel> toEmployeeInfoRepository(String id);
}
