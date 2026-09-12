import 'package:storecs/features/profit_loss_page/data/model/profit_loss_model.dart';

abstract class ProfitLossDataSourceRepository {
  Future<ProfitLossModel> storeProfitLossDataSourceRepo(
    String orderId,
    String orderType,
    double totalPrice,
  );
  Future<List<ProfitLossModel>> getProfitLossLogsDataSourceRepo();
}
