import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/pos_data_source_repo.dart';
import 'package:storecs/features/pos_page/data/model/pos_model.dart';

class PosDataSourceImplementer implements PosDataSourceRepo {
  final Dio dio;
  PosDataSourceImplementer({required this.dio});
  @override
  Future<List<POSModel>> toPosRepositoryGetAllProducts() async {
    final getAllProducts = '${Env.baseURL}getAllProductsRoute';
    final res = await dio.get(getAllProducts);
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return [];
      } else {
        final List<dynamic> allData = res.data;
        return allData.map((go) => POSModel.fromPOSSnapshot(go)).toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching all products Server Error: ${res.statusCode}",
      );
    }
  }
}
