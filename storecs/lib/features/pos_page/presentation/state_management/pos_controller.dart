import 'package:get/get.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/domain/repository/pos_repo.dart';

class PosController extends GetxController {
  final PosRepo repo;
  PosController({required this.repo});

  List<PosEntities> entities = [];
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
}
