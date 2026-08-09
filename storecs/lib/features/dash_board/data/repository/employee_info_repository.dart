import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/employee_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/model/employee_info_model.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/employee_info_repo.dart';

class EmployeeInfoImplement implements EmployeeInfoRepo {
  final EmployeeInfoDataSourceRepo dataSource;
  const EmployeeInfoImplement({required this.dataSource});
  @override
  Future<EmployeeInfoEntities> toEmployeeInfoRepo(String id) async {
    try {
      final EmployeeInfoModel model = await dataSource.toEmployeeInfoRepository(
        id,
      );
      return model.toEmployeeInfoEntities();
    } catch (e) {
      print("any errors in EmployeeImplements $e");
      throw e.toString();
    }
  }

  @override
  Future<EmployeeInfoEntities> toEmployeeStatusRepository(
    String id,
    UserAccountStatus status,
  ) async {
    try {
      final model = await dataSource.toEmployeeStatusDataSourceRepository(
        id,
        status,
      );
      return model.toEmployeeInfoEntities();
    } catch (e) {
      print("any errors in status in EmployeeImplements $e");
      throw e.toString();
    }
  }
}
