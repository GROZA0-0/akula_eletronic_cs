import 'package:storecs/features/settings_page/data/model/stock_alerts_model/low_stock_item_model.dart';
import 'package:storecs/features/settings_page/data/model/stock_alerts_model/stock_alerts_model.dart';

abstract class StocksAlertDataSourceRepo {
  Future<void> saveStockThresholdsDataSourceRepository(
    Map<String, int> threshold,
    Map<String, bool> alertShow,
  );
  Future<Map<String, int>> getStockThresholdsDataSourceRepository();
  Future<List<LowStockItemModel>> getLowStockItemsDataSourceRepository();
  Future<StockAlertsModel> getStockAlertsStatus();
}
