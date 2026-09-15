import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/stocks_Alerts_entities.dart';

class StockAlertsModel {
  final String category;
  final int threshold;

  StockAlertsModel({required this.category, required this.threshold});

  static StockAlertsModel emptyStockAlertsModel() {
    return StockAlertsModel(category: '', threshold: 0);
  }

  factory StockAlertsModel.fromJson(Map<String, dynamic> map) {
    return StockAlertsModel(
      category: map['category'].toString(),
      threshold: (map['threshold'] as num?)?.toInt() ?? 0,
    );
  }

  StocksAlertsEntities toStocksAlertsEntities() {
    return StocksAlertsEntities(category: category, threshold: threshold);
  }
}
