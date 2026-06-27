import 'package:storecs/features/pos_page/data/model/pos_model.dart';

abstract class PosDataSourceRepo {
  Future<List<POSModel>> toPosRepositoryGetAllProducts();
}
