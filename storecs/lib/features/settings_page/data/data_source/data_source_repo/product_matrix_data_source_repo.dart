import 'package:storecs/features/settings_page/data/model/product_matrix_model.dart';

abstract class ProductMatrixDataSourceRepo {
  Future<List<ProductMatrixModel>> getItemsAttributesWithCategories();
}
