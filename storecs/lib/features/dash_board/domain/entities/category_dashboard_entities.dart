import 'package:equatable/equatable.dart';

class CategoryDashboardEntities extends Equatable {
  final String category;
  final double avgValue;
  const CategoryDashboardEntities({
    required this.avgValue,
    required this.category,
  });

  factory CategoryDashboardEntities.fromCachedJson(Map<String, dynamic> json) {
    return CategoryDashboardEntities(
      category: json['category'] ?? '',
      avgValue: (json['avgValue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toCachedJson() {
    return {"category": category, "avgValue": avgValue};
  }

  @override
  List<Object?> get props => [category, avgValue];
}
