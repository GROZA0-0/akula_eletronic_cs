import 'package:storecs/features/order_purchased_history/data/model/order_purchased_history_model.dart';

abstract class OrderPurchasedHistoryDataSourceRepo {
  Future<List<OrderPurchasedHistoryModel>> soldHistorcal();
}
