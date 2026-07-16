import 'package:equatable/equatable.dart';
import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';

class StoreTheRefundInfoEntities extends Equatable {
  final String orderId;
  final String refundReason;
  final double totalRefundAmount;
  final List<RefundItemModel> items;

  const StoreTheRefundInfoEntities({
    required this.orderId,
    required this.refundReason,
    required this.totalRefundAmount,
    required this.items,
  });

  @override
  List<Object?> get props => [orderId, refundReason, totalRefundAmount, items];
}
