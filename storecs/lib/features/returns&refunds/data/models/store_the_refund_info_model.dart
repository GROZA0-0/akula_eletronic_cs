import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/domain/entities/store_the_refund_info_entities.dart';

class StoreTheRefundInfoModel {
  final String? orderId;
  final bool? restoreInventory;
  final String refundReason;
  final double totalRefundAmount;
  final List<RefundItemModel> items;
  final DateTime createAt;

  StoreTheRefundInfoModel({
    required this.orderId,
    required this.restoreInventory,
    required this.refundReason,
    required this.totalRefundAmount,
    required this.items,
    required this.createAt,
  });

  static StoreTheRefundInfoModel emptyRefund() {
    return StoreTheRefundInfoModel(
      orderId: '',
      restoreInventory: false,
      refundReason: '',
      totalRefundAmount: 0.0,
      items: [],
      createAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "refundReason": refundReason,
    "totalRefundAmount": totalRefundAmount,
    "items": items.map((e) => e.toJson()),
  };

  factory StoreTheRefundInfoModel.fromJson(Map<String, dynamic> map) {
    return StoreTheRefundInfoModel(
      orderId: map['orderId']?.toString() ?? '',
      restoreInventory: map['restoreInventory'] ?? false,
      refundReason: map['refundReason'] ?? '',
      totalRefundAmount: (map['totalRefundAmount'] ?? 0.0),
      items: map['items'] != null
          ? List<RefundItemModel>.from(
              map['items'].map((x) => RefundItemModel.fromJson(x)),
            )
          : [],
      createAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
    );
  }

  StoreTheRefundInfoEntities toStoreTheRefundInfoEntities() {
    return StoreTheRefundInfoEntities(
      orderId: orderId ?? '',
      refundReason: refundReason,
      totalRefundAmount: totalRefundAmount,
      items: items,
    );
  }
}
