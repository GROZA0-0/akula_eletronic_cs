import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/low_stock_item_entities.dart';
import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/stocks_Alerts_entities.dart';

abstract class StockAlertsRepository {
  Future<void> saveStockThresholdsRepository(
    Map<String, int> threshold,
    Map<String, bool> alertShow,
  );
  Future<List<LowStockItemEntities>> getLowStockItemsRepository();
  Future<Map<String, int>> getStockThresholdsRepository();
  Future<StocksAlertsEntities> getStockAlertsStatus();
}
