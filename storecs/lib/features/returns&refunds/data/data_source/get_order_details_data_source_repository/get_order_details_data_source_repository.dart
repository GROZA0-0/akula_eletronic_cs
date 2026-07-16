import 'package:storecs/features/returns&refunds/data/models/order_details_model.dart';

abstract class GetOrderDetailsDataSourceRepository {
  Future<OrderDetailsModel> searchByOrderId(String orderId);
}
