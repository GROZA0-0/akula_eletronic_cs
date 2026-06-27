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
    double price,
    double costPrice,
    double stock,
  ) async {
    final insertProductInfro = '${Env.baseURL}storeProductInPhoneTableRoute';
    final data = {
      "pName": name,
      "pBrand": brand,
      "pCategory": category,
      "pImage": image,
      "pBarcode": barcode,
      "pDescription": description,
      "pPrice": 0,
      "pCostPrice": 0,
      "pStock": 0,
    };
    final res = await client.post(
      insertProductInfro,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.data == 200 || res.data == 201) {
      if (res.data == null) {
        return ProductListModel.emptyProductMap();
      } else {
        final data = res.data;
        return ProductListModel.fromProductSnapShot(data);
      }
    } else {
      throw Exception("Any issue with creating product ? : ${res.statusCode}");
    }
  }
}
