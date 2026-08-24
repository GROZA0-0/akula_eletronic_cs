import 'package:storecs/features/settings_page/domain/entities/tax_rules_entities.dart';

abstract class TaxRulesRepository {
  Future<TaxRulesEntities> storeTaxRulesRepo(
    String taxName,
    double rate,
    bool appliesTo,
    String basis,
  );
}
