import 'package:storecs/features/settings_page/domain/entities/tax_rules_entities.dart';

class TaxRulesModel {
  final String taxName;
  final int rate;
  final bool appliesTo;
  final String basis;

  TaxRulesModel({
    required this.taxName,
    required this.rate,
    required this.appliesTo,
    required this.basis,
  });

  Map<String, dynamic> toJson() {
    return {"taxName": taxName, "rate": 0.0, "appliesTo": true, "basis": basis};
  }

  static TaxRulesModel emptyTaxRulesModel() {
    return TaxRulesModel(taxName: '', rate: 0, appliesTo: false, basis: '');
  }

  factory TaxRulesModel.fromJson(Map<String, dynamic> map) {
    return TaxRulesModel(
      taxName: map['taxName'] ?? '',
      rate: map['rate'] ?? 0.0,
      appliesTo: map['appliesTo'] ?? false,
      basis: map['basis'] ?? '',
    );
  }

  TaxRulesEntities toTaxRulesEntities() {
    return TaxRulesEntities(
      taxName: taxName,
      rate: rate,
      appliesTo: appliesTo,
      basis: basis,
    );
  }
}
