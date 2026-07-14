import 'package:storecs/features/order_purchased_history/data/data_source/order_purchased_history_data_source_repo/order_purchased_history_data_source_repo.dart';
import 'package:storecs/features/order_purchased_history/data/model/order_purchased_history_model.dart';
import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';
import 'package:storecs/features/order_purchased_history/domain/repository/order_purchased_history_repo.dart';

class OrderPurchasedHistoryImplementer implements OrderPurchasedHistoryRepo {
  final OrderPurchasedHistoryDataSourceRepo sourceRepo;
  OrderPurchasedHistoryImplementer({required this.sourceRepo});
  @override
  Future<List<OrderPurchasedHistoryEntities>> soldHisRepository() async {
    try {
      final List<OrderPurchasedHistoryModel> data = await sourceRepo
          .soldHistorcal();
      return data
          .map((hist) => hist.toOrderPurchasedHistoryEntities())
          .toList();
    } catch (e) {
      print("any errors in OrderPurchasedHistoryImplementer $e");
      throw e.toString();
    }
  }
}
