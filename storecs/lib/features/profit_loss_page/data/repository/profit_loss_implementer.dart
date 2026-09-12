import 'package:storecs/features/profit_loss_page/data/data_source/profit_loss_data_source_repository/profit_loss_data_source_repository.dart';
import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';
import 'package:storecs/features/profit_loss_page/domain/repository/profit_loss_repository.dart';

class ProfitLossImplementer implements ProfitLossRepository {
  final ProfitLossDataSourceRepository repository;
  ProfitLossImplementer({required this.repository});

  @override
  Future<ProfitLossEntities> storeProfitLossRepo(
    String orderId,
    String orderType,

    /*  List<dynamic> orderList, */
    double totalPrice,
  ) async {
    try {
      final model = await repository.storeProfitLossDataSourceRepo(
        orderId,
        orderType,
        /*  orderList, */
        totalPrice,
      );
      return model.toProfitLossEntities();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  @override
  Future<List<ProfitLossEntities>> getProfitLossLogsRepo() async {
    try {
      final model = await repository.getProfitLossLogsDataSourceRepo();
      return model.map((e) => e.toProfitLossEntities()).toList();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
