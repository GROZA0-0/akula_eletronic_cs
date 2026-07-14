import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';

abstract class OrderPurchasedHistoryRepo {
  Future<List<OrderPurchasedHistoryEntities>> soldHisRepository();
}
