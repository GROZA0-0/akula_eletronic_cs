import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/tax_rules_data_source_repo.dart';

import 'package:storecs/features/settings_page/data/model/tax_rules_model.dart';

class TaxRulesDataSourceImplementer implements TaxRulesDataSourceRepo {
  final Dio dio;
  TaxRulesDataSourceImplementer({required this.dio});

  @override
  Future<TaxRulesModel> storeTaxRulesDataSourceRepo(
    String taxName,
    double rate,
    bool appliesTo,
    String basis,
  ) async {
    final storeTax = '${Env.baseURL}storeTaxRulesRoute';
    final data = {
      'taxName': taxName,
      'rate': rate,
      'appliesTo': appliesTo,
      'basis': basis,
    };
    final res = await dio.post(
      storeTax,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return TaxRulesModel.emptyTaxRulesModel();
      } else {
        final data = res.data['data'];
        return TaxRulesModel.fromJson(data);
      }
    }
    else{
      throw Exception("Any issue with creating tax rules ? : ${res.statusCode}");
    }
  }
}
