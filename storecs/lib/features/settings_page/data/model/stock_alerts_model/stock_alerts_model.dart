import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/stocks_Alerts_entities.dart';

class StockAlertsModel {
  final String category;
  final int threshold;
  final Map<String, bool> stockAlert;

  StockAlertsModel({
    required this.category,
    required this.threshold,
    required this.stockAlert,
  });

  static StockAlertsModel emptyStockAlertsModel() {
    return StockAlertsModel(category: '', threshold: 0, stockAlert: {});
  }

  factory StockAlertsModel.fromJson(Map<String, dynamic> map) {
    return StockAlertsModel(
      category: map['category'].toString(),
      threshold: (map['threshold'] as num?)?.toInt() ?? 0,
      stockAlert: parseBoolMap('stockAlert'),
    );
  }

  StocksAlertsEntities toStocksAlertsEntities() {
    return StocksAlertsEntities(
      category: category,
      threshold: threshold,
      stockAlert: stockAlert,
    );
  }

  static Map<String, bool> parseBoolMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value.map((key, val) => MapEntry(key, val as bool));
    }
    return {}; // handles null, List, or any unexpected shape safely
  }
}
