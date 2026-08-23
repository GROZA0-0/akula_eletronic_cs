import 'package:equatable/equatable.dart';
import 'package:storecs/features/order_purchased_history/data/model/order_purchased_history_items_details.dart';

class OrderPurchasedHistoryEntities extends Equatable {
  final String orderId;
  final List<OrderPurchasedHistoryItemsDetails> items;
  final double totalPrice;
  final String seller;
  final DateTime time;

  const OrderPurchasedHistoryEntities({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.seller,
    required this.time,
  });

  @override
  List<Object?> get props => [orderId, items, totalPrice, seller, time];
}
