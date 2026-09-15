import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ProfitLossEntities extends Equatable {
  final String orderId;
  final String orderType;
  final double totalPrice;
  DateTime? createdAt;

  ProfitLossEntities({
    required this.orderId,
    required this.orderType,
    required this.totalPrice,
    this.createdAt,
  });
  @override
  List<Object?> get props => [orderId, orderType, totalPrice, createdAt];
}
