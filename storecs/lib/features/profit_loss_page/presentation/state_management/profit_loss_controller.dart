import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';
import 'package:storecs/features/profit_loss_page/domain/repository/profit_loss_repository.dart';
import 'package:storecs/main.dart';

class ProfitLossController {
  final ProfitLossRepository repository;
  ProfitLossController({required this.repository});

  List<ProfitLossEntities> entities = [];
  final Alerts alerts = Alerts(messengerKey);

  Future<void> storeCase(
    String orderId,
    String orderType,
    double totalPrice,
  ) async {
    try {
      await repository.storeProfitLossRepo(orderId, orderType, totalPrice);
    } catch (e) {
      print("Something went wrong. $e");
      alerts.ifErrors("Something went wrong.");
    }
  }

  Future<List<ProfitLossEntities>> getLogs() async {
    try {
      final showAll = await repository.getProfitLossLogsRepo();
      entities = showAll.toList();
      return showAll;
    } catch (e) {
      print("error in ProfitLoss controller $e");
      throw e.toString();
    }
  }
}
