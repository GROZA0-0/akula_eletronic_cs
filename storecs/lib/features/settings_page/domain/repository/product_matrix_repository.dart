import 'package:storecs/features/settings_page/domain/entities/product_matrix_entities.dart';

abstract class ProductMatrixRepository {
  Future<List<ProductMatrixEntities>>
  getItemsAttributesWithCategoriesEntities();
}
