import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/low_stock_item_entities.dart';

abstract class StockAlertsRepository {
  Future<void> saveStockThresholdsRepository(Map<String, int> threshold);
  Future<List<LowStockItemEntities>> getLowStockItemsRepository();
  Future<Map<String, int>> getStockThresholdsRepository();
}
