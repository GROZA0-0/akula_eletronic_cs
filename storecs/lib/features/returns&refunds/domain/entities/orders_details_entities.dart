import 'package:equatable/equatable.dart';
import 'package:storecs/features/returns&refunds/data/models/items_details_model.dart';

class OrdersDetailsEntities extends Equatable {
  final String orderId;
  final List<ItemsDetailsModel> items;
  final double totalPrice;
  final DateTime time;

  const OrdersDetailsEntities({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.time,
  });

  @override
  List<Object?> get props => [orderId, items, totalPrice, time];
}
