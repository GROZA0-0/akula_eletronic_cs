import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/Styles/Loader.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/features/settings_page/domain/repository/customer_display_repository.dart';
import 'package:storecs/main.dart';

class CustomerDisplayController extends ChangeNotifier {
  final CustomerDisplayRepository repository;
  CustomerDisplayController({required this.repository});

  Map<String, bool> secondScreenEnabled = {};
  Map<String, bool> showLiveTotals = {};
  Map<String, bool> showItemList = {};
  Map<String, bool> showPromotionalImages = {};
  Map<String, bool> requireDigitalSignature = {};
  Map<String, bool> showThankYouScreen = {};
  Alerts alerts = Alerts(messengerKey);
  List<String> idleScreenOptions = [
    'Promotional Images',
    'Store Logo',
    'Blank Screen',
  ];
  String selectedScreenOption = '';
  void changeOption(String level) {
    selectedScreenOption = level;
    notifyListeners();
  }

  Future<void> storeCustomerScreenSettings() async {
    Loader.startLoading();
    try {
      await repository.storeCustomerDisplayRepository(
        secondScreenEnabled,
        showLiveTotals,
        showItemList,
        showPromotionalImages,
        requireDigitalSignature,
        showThankYouScreen,
        selectedScreenOption,
      );
      Loader.stopLoading();
      alerts.ifSuccess('Customer Display Screen Stored ! ');
      notifyListeners();
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }

  Future<void> getCustomerScreenSettings() async {
    try {
      final data = await repository.getCustomerDisplayDataSourceRepo();
      secondScreenEnabled = data.secondScreenEnabled;
      showLiveTotals = data.showLiveTotals;
      showItemList = data.showItemList;
      showPromotionalImages = data.showPromotionalImages;
      requireDigitalSignature = data.requireDigitalSignature;
      showThankYouScreen = data.showThankYouScreen;
      selectedScreenOption = data.idleScreenOptions;
      notifyListeners();
    } on PlatformException catch (e) {
      alerts.ifErrors(e.message.toString());
    }
  }
}
