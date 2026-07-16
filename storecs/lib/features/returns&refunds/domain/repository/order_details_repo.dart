import 'package:storecs/features/returns&refunds/domain/entities/orders_details_entities.dart';

abstract class OrderDetailsRepo {
  Future<OrdersDetailsEntities> getOrderDetails(String orderId);
}
