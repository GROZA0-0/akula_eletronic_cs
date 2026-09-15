import 'package:equatable/equatable.dart';

class LowStockItemEntities extends Equatable {
  final String id;
  final String brand;
  final String name;
  final String category;
  final int stock;
  final int threshold;

  const LowStockItemEntities({
    required this.id,
    required this.brand,
    required this.name,
    required this.category,
    required this.stock,
    required this.threshold,
  });

  @override
  List<Object?> get props => [id, brand, name, category, stock, threshold];
}
