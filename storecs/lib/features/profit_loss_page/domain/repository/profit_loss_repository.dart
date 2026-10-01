import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';

abstract class ProfitLossRepository {
  Future<ProfitLossEntities> storeProfitLossRepo(
    String orderId,
    String orderType,
    double totalPrice,
    String fullName,
  );

  Future<List<ProfitLossEntities>> getProfitLossLogsRepo();
}
