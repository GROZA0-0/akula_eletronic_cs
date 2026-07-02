import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';

abstract class PosRepo {
  Future<List<PosEntities>> toGetAllProductsRepo();
  Future<List<PosEntities>> toGetProductsWithCategoriesRepo(String category);
}
