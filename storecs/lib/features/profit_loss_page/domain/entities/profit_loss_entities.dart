import 'package:equatable/equatable.dart';

class ProfitLossEntities extends Equatable {
  final String orderId;
  final String orderType;
  final double totalPrice;

  const ProfitLossEntities({
    required this.orderId,
    required this.orderType,
    required this.totalPrice,
  });
  @override
  List<Object?> get props => [orderId, orderType, totalPrice];
}
