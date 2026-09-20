import 'package:storecs/features/settings_page/domain/entities/customer_display_entities.dart';

class CustomerDisplayModel {
  final Map<String, bool> secondScreenEnabled;
  final Map<String, bool> showLiveTotals;
  final Map<String, bool> showItemList;
  final Map<String, bool> showPromotionalImages;
  final Map<String, bool> requireDigitalSignature;
  final Map<String, bool> showThankYouScreen;
  final String idleScreenOptions;

  CustomerDisplayModel({
    required this.secondScreenEnabled,
    required this.showLiveTotals,
    required this.showItemList,
    required this.showPromotionalImages,
    required this.requireDigitalSignature,
    required this.showThankYouScreen,
    required this.idleScreenOptions,
  });

  static CustomerDisplayModel emptyCustomerDisplayModel() {
    return CustomerDisplayModel(
      secondScreenEnabled: {},
      showLiveTotals: {},
      showItemList: {},
      showPromotionalImages: {},
      requireDigitalSignature: {},
      showThankYouScreen: {},
      idleScreenOptions: '',
    );
  }

  static Map<String, bool> parseBoolMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value.map((key, val) => MapEntry(key, val as bool));
    }
    return {};
  }

  factory CustomerDisplayModel.fromJson(Map<String, dynamic> map) {
    return CustomerDisplayModel(
      secondScreenEnabled: parseBoolMap(map['secondScreenEnabled']),
      showLiveTotals: parseBoolMap(map['showLiveTotals']),
      showItemList: parseBoolMap(map['showItemList']),
      showPromotionalImages: parseBoolMap(map['showPromotionalImages']),
      requireDigitalSignature: parseBoolMap(map['requireDigitalSignature']),
      showThankYouScreen: parseBoolMap(map['showThankYouScreen']),
      idleScreenOptions: map['idleScreenOptions'] ?? '',
    );
  }

  CustomerDisplayEntities toCustomerDisplayEntities() {
    return CustomerDisplayEntities(
      secondScreenEnabled: secondScreenEnabled,
      showLiveTotals: showLiveTotals,
      showItemList: showItemList,
      showPromotionalImages: showPromotionalImages,
      requireDigitalSignature: requireDigitalSignature,
      showThankYouScreen: showThankYouScreen,
      idleScreenOptions: idleScreenOptions,
    );
  }
}
