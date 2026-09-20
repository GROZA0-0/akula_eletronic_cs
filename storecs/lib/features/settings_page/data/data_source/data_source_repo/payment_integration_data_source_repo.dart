import 'package:storecs/features/settings_page/data/model/payment_integration_model.dart';

abstract class PaymentIntegrationDataSourceRepo {
  Future<void> storePaymentIntegrationMoudleDataSourceRepo(
    Map<String, bool> paymentMethod,
    double minimumCardPayTextField,
    String giftCardCodePrefix,
    Map<String, bool> checkoutOptions,
  );
  Future<PaymentIntegrationModel> getPaymentIntegrationMoudleDataSourceRepo();
}
