import 'package:storecs/features/returns&refunds/data/models/items_details_model.dart';
import 'package:storecs/features/returns&refunds/domain/entities/orders_details_entities.dart';

class OrderDetailsModel {
  final String orderId;
  final List<ItemsDetailsModel> items;
  final double totalPrice;
  final DateTime time;

  OrderDetailsModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.time,
  });

  static OrderDetailsModel emptyOrderData() {
    return OrderDetailsModel(
      orderId: '',
      items: [],
      totalPrice: 0.0,
      time: DateTime.now(),
    );
  }

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailsModel(
      orderId: json['orderId'] ?? '',
      items: json['items'] != null
          ? List<ItemsDetailsModel>.from(
              json['items'].map((x) => ItemsDetailsModel.fromJson(x)),
            )
          : [],
      totalPrice: (json['totalPrice'] ?? 0.0),
      time: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
  OrdersDetailsEntities toOrderPurchasedHistoryEntities() {
    return OrdersDetailsEntities(
      orderId: orderId,
      items: items,
      totalPrice: totalPrice,
      time: time,
    );
  }
}
