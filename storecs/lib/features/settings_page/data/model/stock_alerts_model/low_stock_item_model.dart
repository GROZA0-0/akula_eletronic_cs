import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/low_stock_item_entities.dart';

class LowStockItemModel {
  final String id;
  final String brand;
  final String name;
  final String category;
  final int stock;
  final int threshold;

  LowStockItemModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.stock,
    required this.threshold,
  });

  factory LowStockItemModel.fromJosn(Map<String, dynamic> map) {
    return LowStockItemModel(
      id: map['_id'] ?? '',
      brand: map['pBrand'] ?? '',
      name: map['pName'] ?? '',
      category: map['pCategory'] ?? '',
      stock: (map['pStock'] as num?)?.toInt() ?? 0,
      threshold: (map['threshold'] as num?)?.toInt() ?? 0,
    );
  }

  LowStockItemEntities toLowStockItemEntities() {
    return LowStockItemEntities(
      id: id,
      brand: brand,
      name: name,
      category: category,
      stock: stock,
      threshold: threshold,
    );
  }
}
