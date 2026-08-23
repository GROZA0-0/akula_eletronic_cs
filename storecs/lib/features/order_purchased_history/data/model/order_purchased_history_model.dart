import 'package:storecs/features/order_purchased_history/data/model/order_purchased_history_items_details.dart';
import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';

class OrderPurchasedHistoryModel {
  final String orderId;
  final List<OrderPurchasedHistoryItemsDetails> items;
  final double totalPrice;
  final String seller;
  final DateTime time;

  OrderPurchasedHistoryModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.seller,
    required this.time,
  });

  factory OrderPurchasedHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderPurchasedHistoryModel(
      orderId: json['orderId'] ?? '',
      items: json['items'] != null
          ? List<OrderPurchasedHistoryItemsDetails>.from(
              json['items'].map(
                (x) => OrderPurchasedHistoryItemsDetails.fromJson(x),
              ),
            )
          : [],
      totalPrice: json['totalPrice'] ?? 0.0,
      seller: json['sold_by'].toString(),
      time: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
  OrderPurchasedHistoryEntities toOrderPurchasedHistoryEntities() {
    return OrderPurchasedHistoryEntities(
      orderId: orderId,
      items: items,
      totalPrice: totalPrice,
      seller: seller,
      time: time,
    );
  }
}
