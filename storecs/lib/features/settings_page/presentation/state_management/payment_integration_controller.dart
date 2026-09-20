import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/settings_page/domain/repository/payment_integration_repository.dart';
import 'package:storecs/main.dart';

class PaymentIntegrationController extends ChangeNotifier {
  final PaymentIntegrationRepository repository;
  PaymentIntegrationController({required this.repository});
  final TextEditingController giftCardPrefixController = TextEditingController(
    text: 'GC-',
  );
  final TextEditingController minCardAmountController = TextEditingController(
    text: '0.0',
  );
  final Alerts alerts = Alerts(messengerKey);

  Map<String, bool> paymentMethodOptions = {};
  Map<String, bool> allowOptions = {};
  Map<String, dynamic> checkoutOptionsSubTitle = {};

  Future<void> storePayment() async {
    Loader.startLoading();
    try {
      await repository.storePaymentIntegrationMoudleRepo(
        paymentMethodOptions,
        double.parse(minCardAmountController.text.trim()),
        giftCardPrefixController.text.trim(),
        allowOptions,
      );
      Loader.stopLoading();
      alerts.ifSuccess('Payment Method Stored');
      notifyListeners();
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }

  Future<void> getPayment() async {
    try {
      final data = await repository.getPaymentIntegrationMoudleRepo();
      paymentMethodOptions = data.paymentMethod;
      allowOptions = data.checkoutOptions;
      checkoutOptionsSubTitle = data.checkoutOptionsSubTitle;
      notifyListeners();
      // print('Parsed restrictedActions: ${data.paymentMethod}');
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    }
  }
}
