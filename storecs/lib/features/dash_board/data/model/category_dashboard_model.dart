import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';

class CategoryDashboardModel {
  final String category;
  final double avgValue;

  CategoryDashboardModel({required this.avgValue, required this.category});

  factory CategoryDashboardModel.fromJson(Map<String, dynamic> json) {
    return CategoryDashboardModel(
      category: json['category'] ?? '',
      avgValue: (json['avgValue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  CategoryDashboardEntities toCategoryDashboardEntities() {
    return CategoryDashboardEntities(avgValue: avgValue, category: category);
  }
}
