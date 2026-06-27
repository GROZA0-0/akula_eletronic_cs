import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/pos_data_source_repo.dart';
import 'package:storecs/features/pos_page/data/model/pos_model.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/domain/repository/pos_repo.dart';

class PosRepository implements PosRepo {
  final PosDataSourceRepo repo;
  PosRepository({required this.repo});
  @override
  Future<List<PosEntities>> toGetAllProductsRepo() async {
    try {
      final List<POSModel> model = await repo.toPosRepositoryGetAllProducts();
      return model.map((e) => e.toPosEntities()).toList();
    } catch (e) {
      print("any errors in Pos Repo Implements  $e");
      throw e.toString();
    }
  }
}
