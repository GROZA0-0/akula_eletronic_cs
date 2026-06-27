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
    final insertProductInfro = '${Env.baseURL}storeProductInPhoneTableRoute';
    final data = {
      "pName": name,
      "pBrand": brand,
      "pCategory": category,
      "pImage": image,
      "pBarcode": barcode,
      "pDescription": description,
      "pPrice": double.tryParse(price) ?? '0.0',
      "pCostPrice": double.tryParse(price) ?? '0.0',
      "pStock": int.tryParse(price) ?? '0.0',
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
}
