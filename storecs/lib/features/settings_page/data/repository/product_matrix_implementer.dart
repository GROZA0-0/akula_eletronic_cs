import 'package:storecs/features/settings_page/data/data_source/data_source_repo/product_matrix_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/product_matrix_model.dart';
import 'package:storecs/features/settings_page/domain/entities/product_matrix_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/product_matrix_repository.dart';

class ProductMatrixImplementer implements ProductMatrixRepository {
  final ProductMatrixDataSourceRepo dataSourceRepo;
  ProductMatrixImplementer({required this.dataSourceRepo});

  @override
  Future<List<ProductMatrixEntities>>
  getItemsAttributesWithCategoriesEntities() async {
    try {
      final List<ProductMatrixModel> model = await dataSourceRepo
          .getItemsAttributesWithCategories();
      return model.map((get) => get.toProductMatrixEntities()).toList();
    } catch (e) {
      print("any errors in ProductMatrixImplementer $e");
      throw e.toString();
    }
  }
}
