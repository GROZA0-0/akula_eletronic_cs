import 'package:equatable/equatable.dart';

class PaymentIntegrationEntities extends Equatable {
  final Map<String, bool> paymentMethod;
  final double minimumCardPayTextField;
  final String giftCardCodePrefix;
  final Map<String, bool> checkoutOptions;
  final Map<String, dynamic> checkoutOptionsSubTitle;

  const PaymentIntegrationEntities({
    required this.paymentMethod,
    required this.minimumCardPayTextField,
    required this.giftCardCodePrefix,
    required this.checkoutOptions,
    required this.checkoutOptionsSubTitle,
  });

  @override
  List<Object?> get props => [
    paymentMethod,
    minimumCardPayTextField,
    giftCardCodePrefix,
    checkoutOptions,
    checkoutOptionsSubTitle,
  ];
}
