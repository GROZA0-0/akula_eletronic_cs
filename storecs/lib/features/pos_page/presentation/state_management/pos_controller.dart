import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/domain/repository/pos_repo.dart';

class PosController {
  final PosRepo repo;
  PosController({required this.repo});

  List<PosEntities> entities = [];
  final List<CartEntities> cartItems = [];
  Future<List<PosEntities>> getAllProducts() async {
    try {
      final products = await repo.toGetAllProductsRepo();
      entities = products.toList();
      return products;
    } catch (e) {
      print("error in dashboard controller $e");
      throw e.toString();
    }
  }

  Stream<List<PosEntities>> getCategoriesWithItems(String category) async* {
    try {
      final product = await repo.toGetProductsWithCategoriesRepo(category);
      entities = product;
      yield entities;
      await for (final _ in repo.getItems) {
        final product = await repo.toGetProductsWithCategoriesRepo(category);
        entities = product;
        yield entities;
      }
    } catch (e) {
      print("error in getCategoriesWithItems controller $e");
      throw e.toString();
    }
  }
}
