import 'package:storecs/features/settings_page/data/data_source/tax_rules_data_source_repo/tax_rules_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/tax_rules_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/tax_rules_repository.dart';

class TaxRulesImplementer implements TaxRulesRepository {
  final TaxRulesDataSourceRepo sourceRepo;
  TaxRulesImplementer(this.sourceRepo);

  @override
  Future<TaxRulesEntities> storeTaxRulesRepo(
    String taxName,
    double rate,
    bool appliesTo,
    String basis,
  ) async {
    try {
      final model = await sourceRepo.storeTaxRulesDataSourceRepo(
        taxName,
        rate,
        appliesTo,
        basis,
      );
      return model.toTaxRulesEntities();
    } catch (e) {
      print("any errors in TaxRulesImplementer $e");
      throw e.toString();
    }
  }
}
