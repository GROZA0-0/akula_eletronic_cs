import 'package:storecs/features/settings_page/domain/entities/product_matrix_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/product_matrix_repository.dart';

class ProductMatrixController {
  final ProductMatrixRepository repository;
  ProductMatrixController(this.repository);

  List<ProductMatrixEntities> entities = [];

  Future<List<ProductMatrixEntities>> fetchAllItemWithCategories() async {
    try {
      final data = await repository.getItemsAttributesWithCategoriesEntities();
      entities = data;
      return data;
    } catch (e) {
      print("error in Product Matrix controller $e");
      throw e.toString();
    }
  }

  Map<String, List<ProductMatrixEntities>> categoriesGrouped(
    List<ProductMatrixEntities>
    items /* get a list of items of each category */,
  ) {
    final Map<String, List<ProductMatrixEntities>> grouped =
        {}; /* use to make a group for categories with own items */
    for (final item in items) {
      grouped
          .putIfAbsent(item.category, () => [])
          .add(item); /* pass the category once , then fetch all items  */
    }
    return grouped;
  }
}
