import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';

class ProfitLossModel {
  final String orderId;
  final String orderType;
  final double totalPrice;
  DateTime? createdAt;

  ProfitLossModel({
    required this.orderId,
    required this.totalPrice,
    required this.orderType,
    this.createdAt,
  });

  static ProfitLossModel emptyProfitLossModel() {
    return ProfitLossModel(
      orderId: '',
      orderType: '',
      totalPrice: 0.0,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "orderType": orderType,
      "totalPrice": totalPrice,
    };
  }

  factory ProfitLossModel.fromJson(Map<String, dynamic> map) {
    return ProfitLossModel(
      orderId: map['orderId'] ?? '',
      orderType: map['orderType'] ?? '',
      totalPrice: (map['totalPrice'] as num?)?.toDouble() ?? 0.0,
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : null,
    );
  }

  ProfitLossEntities toProfitLossEntities() {
    return ProfitLossEntities(
      orderId: orderId,
      createdAt: createdAt,
      orderType: orderType,
      totalPrice: totalPrice,
    );
  }
}
