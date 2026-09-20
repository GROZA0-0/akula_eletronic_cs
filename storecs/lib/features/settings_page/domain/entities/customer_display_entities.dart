import 'package:equatable/equatable.dart';

class CustomerDisplayEntities extends Equatable {
  final Map<String, bool> secondScreenEnabled;
  final Map<String, bool> showLiveTotals;
  final Map<String, bool> showItemList;
  final Map<String, bool> showPromotionalImages;
  final Map<String, bool> requireDigitalSignature;
  final Map<String, bool> showThankYouScreen;
  final String idleScreenOptions;

  const CustomerDisplayEntities({
    required this.secondScreenEnabled,
    required this.showLiveTotals,
    required this.showItemList,
    required this.showPromotionalImages,
    required this.requireDigitalSignature,
    required this.showThankYouScreen,
    required this.idleScreenOptions,
  });

  @override
  List<Object?> get props => [
    secondScreenEnabled,
    showLiveTotals,
    showItemList,
    showPromotionalImages,
    requireDigitalSignature,
    showThankYouScreen,
    idleScreenOptions,
  ];
}
