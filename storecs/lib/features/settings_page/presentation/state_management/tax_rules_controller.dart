import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/features/settings_page/domain/repository/tax_rules_repository.dart';
import 'package:storecs/main.dart';

class TaxRulesController {
  final TaxRulesRepository repository;
  TaxRulesController(this.repository);

  final Alerts alerts = Alerts(messengerKey);
  // Template 1 State Variables
  final TextEditingController taxNameController = TextEditingController(
    text: 'Standard Sales Tax',
  );
  final TextEditingController taxRateController = TextEditingController(
    text: '16.0',
  );

  String taxBasis = 'Tax-Exclusive (Added at checkout)';
  String roundingRule = 'Round to nearest 0.01';
  bool applyToAllProducts = true;

  Future<void> saveTaxRule() async {
    try {
      await repository.storeTaxRulesRepo(
        taxNameController.text.trim(),
        double.parse(taxRateController.text),
        applyToAllProducts,
        taxBasis,
      );
      alerts.ifSuccess('Tax Stores Successfully');
    } catch (e) {
      print("error in tax rules controller $e");
      throw e.toString();
    }
  }
}
