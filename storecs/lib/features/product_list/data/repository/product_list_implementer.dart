import 'package:flutter/services.dart';
import 'package:storecs/features/product_list/data/data_source/product_list_data_source_repo/product_list_data_source_repo.dart';
import 'package:storecs/features/product_list/data/model/product_list_model.dart';
import 'package:storecs/features/product_list/domain/entities/product_list_entities.dart';
import 'package:storecs/features/product_list/domain/repository/product_list_repo.dart';

class ProductListImplementer implements ProductListRepo {
  final ProductListDataSourceRepo implementer;
  ProductListImplementer({required this.implementer});
  @override
  Future<InsertProductListEntities> toInsertProductListRepo(
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
    try {
      final data = await implementer.toProductListDataSourceRepo(
        name,
        brand,
        category,
        image,
        barcode,
        description,
        price,
        costPrice,
        stock,
      );
      return data.toInsertProductListEntities();
    } on PlatformException catch (e) {
      print("any errors in ProductListImplementer ${e.toString()}");
      throw e.message ?? "Authentication sign out failed";
    }
  }

  @override
  Future<List<GetProductWithCategoryListEntities>>
  toGetProductWithGategoryistRepo(String category) async {
    try {
      final List<ProductListModel> data = await implementer
          .toGetProductsByCategory(category);

      return data
          .map(
            (productInfo) => productInfo.toGetProductWithCategoryListEntities(),
          )
          .toList();
    } catch (e) {
      print("any errors in ProductListImplementer $e");
      throw e.toString();
    }
  }
}
