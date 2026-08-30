import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/product_matrix_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/product_matrix_model.dart';

class ProductMatrixDataSourceImplementer
    implements ProductMatrixDataSourceRepo {
  final Dio dio;
  ProductMatrixDataSourceImplementer({required this.dio});

  @override
  Future<List<ProductMatrixModel>> getItemsAttributesWithCategories() async {
    final getByCategory = '${Env.baseURL}getItemsWithCategoryRoute';
    final res = await dio.get(
      getByCategory,
      options: Options(validateStatus: (status) => status! < 600),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return [];
      } else {
        final List categoryGroup = res.data['data'] ?? [];
        final List<ProductMatrixModel> flatten = [];
        for (final group in categoryGroup) {
          /* loop of check each category */
          final String categoryName = group['category'] ?? '';
          final List items = group['items'] ?? [];
          for (final item in items) {
            /* loop of check each item */
            flatten.add(
              ProductMatrixModel.fromJson({
                ...item,
                'pCategory': item['pCategory'] ?? categoryName,
              }),
            );
          }
        }
        return flatten;
      }
    } else {
      throw Exception(
        "Any issue with fetching Items sAttributes Server Error: ${res.statusCode}",
      );
    }
  }
}
