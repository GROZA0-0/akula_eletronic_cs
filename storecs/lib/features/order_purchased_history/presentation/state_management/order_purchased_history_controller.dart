import 'package:storecs/Core/config/date_time_helper.dart';
import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';
import 'package:storecs/features/order_purchased_history/domain/repository/order_purchased_history_repo.dart';

class OrderPurchasedHistoryController {
  final OrderPurchasedHistoryRepo repo;
  OrderPurchasedHistoryController({required this.repo});

  List<OrderPurchasedHistoryEntities> entities = [];

  Future<List<OrderPurchasedHistoryEntities>> getOrdersSoldHistorical() async {
    try {
      final orders = await repo.soldHisRepository();
      print("info of orders [${orders.length}]");
      orders.sort((a, b) => b.time.compareTo(a.time));
      entities = orders.toList();
      return entities;
    } catch (e) {
      print("error in order purchased Historical controller $e");
      throw e.toString();
    }
  }

  Map<String, List<OrderPurchasedHistoryEntities>> get groupedOrders {
    Map<String, List<OrderPurchasedHistoryEntities>> grouped = {};

    for (var order in entities) {
      String header = getDatetimeHeader(order.time);
      if (grouped[header] == null) {
        grouped[header] = [];
      }
      grouped[header]!.add(order);
    }
    return grouped;
  }
}
