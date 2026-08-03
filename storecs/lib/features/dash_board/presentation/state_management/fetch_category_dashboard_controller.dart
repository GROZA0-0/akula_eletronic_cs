import 'package:flutter/material.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/category_dashboard_repo.dart';

class FetchCategoryDashboardController {
  final CategoryDashboardRepo repo;
  FetchCategoryDashboardController({required this.repo});
  static const List<Color> colorPalette = [
    redColor,
    greenColor,
    orange,
    blueColor,
  ];

  Future<List<CategoryDashboardEntities>> fetchChartDashboard() async {
    try {
      final getChart = await repo.getChartRepo();
      return getChart;
    } catch (e) {
      rethrow;
    }
  }

  static List<Map<String, dynamic>> mapCategoryAvgToSalesData(
    List<CategoryDashboardEntities> categoriesData,
  ) {
    /* Filter out invalid items */
    final validCategories = categoriesData
        .where((item) => item.category.isNotEmpty && item.avgValue > 0)
        .toList();

    if (validCategories.isEmpty) {
      return [];
    }

    /* Sort descending */
    validCategories.sort((a, b) => b.avgValue.compareTo(a.avgValue));

    /* Calculate grand total across valid items for percentages */
    double totalAvgSum = validCategories.fold(
      0.0,
      (sum, item) => sum + item.avgValue,
    );

    if (totalAvgSum <= 0) return [];

    final List<Map<String, dynamic>> finalChartData = [];
    const int topCount = 3;
    double othersAvgValue = 0.0;

    for (int i = 0; i < validCategories.length; i++) {
      final item = validCategories[i];

      if (i < topCount) {
        /* Add top 3 categories directly */
        double percentage = (item.avgValue / totalAvgSum) * 100;
        finalChartData.add({
          'label': item.category,
          'value': percentage,
          'avgAmount': item.avgValue,
          'color': colorPalette[i % colorPalette.length],
        });
      } else {
        /* Accumulate remaining items into "Others" sum */
        othersAvgValue += item.avgValue;
      }
    }

    /* Added "Others" group  */
    if (othersAvgValue > 0) {
      final double othersPercentage = (othersAvgValue / totalAvgSum) * 100;
      finalChartData.add({
        'label': 'Others',
        'value': othersPercentage,
        'avgAmount': othersAvgValue,
        'color': colorPalette[finalChartData.length % colorPalette.length],
      });
    }

    return finalChartData;
  }
}
