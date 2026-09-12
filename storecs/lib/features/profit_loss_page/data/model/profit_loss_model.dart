import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';

class ProfitLossModel {
  final String orderId;
  final String orderType;
  final double totalPrice;

  ProfitLossModel({
    required this.orderId,
    required this.totalPrice,
    required this.orderType,
  });

  static ProfitLossModel emptyProfitLossModel() {
    return ProfitLossModel(orderId: '', orderType: '', totalPrice: 0.0);
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
    );
  }

  ProfitLossEntities toProfitLossEntities() {
    return ProfitLossEntities(
      orderId: orderId,

      orderType: orderType,
      totalPrice: totalPrice,
    );
  }
}
