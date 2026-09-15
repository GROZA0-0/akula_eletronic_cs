import 'package:storecs/features/settings_page/data/model/stock_alerts_model/low_stock_item_model.dart';

abstract class StocksAlertDataSourceRepo {
  Future<void> saveStockThresholdsDataSourceRepository(
    Map<String, int> threshold,
  );
  Future<Map<String, int>> getStockThresholdsDataSourceRepository();
  Future<List<LowStockItemModel>> getLowStockItemsDataSourceRepository();
}
