import 'package:storecs/features/settings_page/data/data_source/data_source_repo/payment_integration_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/payment_integration_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/payment_integration_repository.dart';

class PaymentIntegrationImplementer implements PaymentIntegrationRepository {
  final PaymentIntegrationDataSourceRepo repo;
  PaymentIntegrationImplementer({required this.repo});

  @override
  Future<void> storePaymentIntegrationMoudleRepo(
    Map<String, bool> paymentMethod,
    double minimumCardPayTextField,
    String giftCardCodePrefix,
    Map<String, bool> checkoutOptions,
  ) async {
    try {
      await repo.storePaymentIntegrationMoudleDataSourceRepo(
        paymentMethod,
        minimumCardPayTextField,
        giftCardCodePrefix,
        checkoutOptions,
      );
    } catch (e) {
      print("any errors in store PaymentIntegrationImplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<PaymentIntegrationEntities> getPaymentIntegrationMoudleRepo() async {
    try {
      final model = await repo.getPaymentIntegrationMoudleDataSourceRepo();
      return model.toPaymentIntegrationEntities();
    } catch (e) {
      print("any errors in get PaymentIntegrationImplementer $e");
      throw e.toString();
    }
  }
}
