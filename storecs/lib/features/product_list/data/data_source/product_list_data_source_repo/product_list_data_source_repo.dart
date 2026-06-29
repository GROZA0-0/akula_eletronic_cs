import 'package:storecs/features/product_list/data/model/product_list_model.dart';

abstract class ProductListDataSourceRepo {
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
  );

  Future<List<ProductListModel>> toGetProductsByCategory(String category);
}
