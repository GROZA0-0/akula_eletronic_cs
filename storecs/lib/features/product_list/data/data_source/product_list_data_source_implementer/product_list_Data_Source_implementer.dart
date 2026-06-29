import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_repo/product_list_data_source_repo.dart';
import 'package:storecs/features/product_list/data/model/product_list_model.dart';

class ProductListDataSourceImplementer implements ProductListDataSourceRepo {
  final Dio client;
  const ProductListDataSourceImplementer({required this.client});

  @override
  Future<ProductListModel> toProductListDataSourceRepo(
    String name,
    String brand,
    String category,
    String image,
    String barcode,
    String description,
    String price,
    String costPrice,
    String stock,
  ) async {
    final insertProductInfro = '${Env.baseURL}storeProductInTableRoute';
    final data = {
      "pName": name,
      "pBrand": brand,
      "pCategory": category,
      "pImage": image,
      "pBarcode": barcode,
      "pDescription": description,
      "pPrice": price,
      "pCostPrice": costPrice,
      "pStock": stock,
    };
    final res = await client.post(
      insertProductInfro,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return ProductListModel.emptyProductMap();
      } else {
        final data = res.data;
        final productMap = data['data'] ?? data;
        return ProductListModel.fromProductSnapShot(productMap);
      }
    } else {
      throw Exception("Any issue with creating product ? : ${res.statusCode}");
    }
  }

  @override
  Future<List<ProductListModel>> toGetProductsByCategory(
    String category,
  ) async {
    final getByCategory =
        '${Env.baseURL}getProductsByCategoryRoute/categories/$category';
    final res = await client.get(
      getByCategory,
      options: Options(validateStatus: (status) => status! < 600),
    );

    if (res.statusCode == 200) {
      if (res.data == null) {
        return [];
      } else {
        final List list = res.data['data'] ?? '';
        return list
            .map((e) => ProductListModel.fromProductSnapShot(e))
            .toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching items list Server Error: ${res.statusCode}",
      );
    }
  }
}
