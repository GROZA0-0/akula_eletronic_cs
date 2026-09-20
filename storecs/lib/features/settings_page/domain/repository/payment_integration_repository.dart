import 'package:storecs/features/settings_page/domain/entities/payment_integration_entities.dart';

abstract class PaymentIntegrationRepository {
  Future<void> storePaymentIntegrationMoudleRepo(
    Map<String, bool> paymentMethod,
    double minimumCardPayTextField,
    String giftCardCodePrefix,
    Map<String, bool> checkoutOptions,
  );

  Future<PaymentIntegrationEntities> getPaymentIntegrationMoudleRepo();
}
