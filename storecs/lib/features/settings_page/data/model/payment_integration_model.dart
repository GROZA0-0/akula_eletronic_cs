import 'package:storecs/features/settings_page/domain/entities/payment_integration_entities.dart';

class PaymentIntegrationModel {
  final Map<String, bool> paymentMethod;
  final double minimumCardPayTextField;
  final String giftCardCodePrefix;
  final Map<String, bool> checkoutOptions;
  final Map<String, dynamic> checkoutOptionsSubTitle;

  PaymentIntegrationModel({
    required this.paymentMethod,
    required this.minimumCardPayTextField,
    required this.giftCardCodePrefix,
    required this.checkoutOptions,
    required this.checkoutOptionsSubTitle,
  });

  static PaymentIntegrationModel emptyPaymentIntegrationModel() {
    return PaymentIntegrationModel(
      paymentMethod: {},
      minimumCardPayTextField: 0.0,
      giftCardCodePrefix: 'N/A',
      checkoutOptions: {},
      checkoutOptionsSubTitle: {},
    );
  }

  factory PaymentIntegrationModel.fromJson(Map<String, dynamic> map) {
    return PaymentIntegrationModel(
      paymentMethod: parseBoolMap(map['paymentMethod']),
      minimumCardPayTextField:
          (map['minimumCardPayTextField'] as num?)?.toDouble() ?? 0.0,
      giftCardCodePrefix: map['giftCardCodePrefix'] ?? '',
      checkoutOptions: parseBoolMap(map['checkoutOptions']),
      checkoutOptionsSubTitle: map['checkoutOptionsSubTitle'] ?? {},
    );
  }
  static Map<String, bool> parseBoolMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value.map((key, val) => MapEntry(key, val as bool));
    }
    return {}; // handles null, List, or any unexpected shape safely
  }

  PaymentIntegrationEntities toPaymentIntegrationEntities() {
    return PaymentIntegrationEntities(
      paymentMethod: paymentMethod,
      minimumCardPayTextField: minimumCardPayTextField,
      giftCardCodePrefix: giftCardCodePrefix,
      checkoutOptions: checkoutOptions,
      checkoutOptionsSubTitle: checkoutOptionsSubTitle,
    );
  }
}
