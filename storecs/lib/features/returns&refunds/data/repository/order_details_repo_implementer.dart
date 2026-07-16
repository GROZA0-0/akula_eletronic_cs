import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/get_order_details_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/domain/entities/orders_details_entities.dart';
import 'package:storecs/features/returns&refunds/domain/repository/order_details_repo.dart';

class OrderDetailsRepoImplementer implements OrderDetailsRepo {
  final GetOrderDetailsDataSourceRepository repository;
  OrderDetailsRepoImplementer({required this.repository});

  @override
  Future<OrdersDetailsEntities> getOrderDetails(String orderId) async {
    try {
      final model = await repository.searchByOrderId(orderId);
      return model.toOrderPurchasedHistoryEntities();
    } catch (e) {
      print("any errors in OrderDetailsRepoImplementer $e");
      throw e.toString();
    }
  }
}
