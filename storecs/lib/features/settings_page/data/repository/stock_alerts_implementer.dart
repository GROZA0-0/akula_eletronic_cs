import 'package:storecs/features/settings_page/data/data_source/data_source_repo/stocks_alert_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/low_stock_item_entities.dart';

import 'package:storecs/features/settings_page/domain/repository/stock_alerts_repository.dart';

class StockAlertsImplementer implements StockAlertsRepository {
  final StocksAlertDataSourceRepo sourceRepo;
  StockAlertsImplementer({required this.sourceRepo});

  @override
  Future<void> saveStockThresholdsRepository(Map<String, int> threshold) async {
    try {
      await sourceRepo.saveStockThresholdsDataSourceRepository(threshold);
    } catch (e) {
      print("any errors in store StockAlertsImplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<Map<String, int>> getStockThresholdsRepository() async {
    try {
      final model = await sourceRepo.getStockThresholdsDataSourceRepository();
      return model;
    } catch (e) {
      print("any errors in get StockAlertsImplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<List<LowStockItemEntities>> getLowStockItemsRepository() async {
    try {
      final model = await sourceRepo.getLowStockItemsDataSourceRepository();
      return model.map((entity) => entity.toLowStockItemEntities()).toList();
    } catch (e) {
      print("any errors in get LowStockAlertsImplementer $e");
      throw e.toString();
    }
  }
}
