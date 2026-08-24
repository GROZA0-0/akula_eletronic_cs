import 'package:storecs/features/settings_page/data/model/tax_rules_model.dart';

abstract class TaxRulesDataSourceRepo {
  Future<TaxRulesModel> storeTaxRulesDataSourceRepo(
    String taxName,
    double rate,
    bool appliesTo,
    String basis,
  );
}
