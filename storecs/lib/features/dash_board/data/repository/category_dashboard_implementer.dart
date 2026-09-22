import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/category_dashboard_data_source_repo.dart';
import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/category_dashboard_repo.dart';

class CategoryDashboardImplementer implements CategoryDashboardRepo {
  final CategoryDashboardDataSourceRepo sourceRepo;
  CategoryDashboardImplementer({required this.sourceRepo});

  final controller = BehaviorSubject<List<CategoryDashboardEntities>>();
  static const chartCached = 'chart_cached';

  @override
  Future<List<CategoryDashboardEntities>> getChartRepo() async {
    try {
      final model = await sourceRepo.getCategoryAvgSales();
      final entity = model.map((e) => e.toCategoryDashboardEntities()).toList();
      controller.add(entity);
      savedToCachedData(entity);
      return entity;
    } catch (e) {
      // print("any errors in CategoryDashboardImplementer $e");
      return controller.valueOrNull ?? [];
    }
  }

  @override
  Stream<List<CategoryDashboardEntities>> get getChart => controller.stream;

  @override
  Future<void> reviewInfoLoadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(chartCached);
    if (cached != null) {
      final List<dynamic> lastChartData = jsonDecode(cached);
      final entities = lastChartData
          .map((e) => CategoryDashboardEntities.fromCachedJson(e))
          .toList();
      controller.add(entities);
    }
  }

  @override
  Future<void> savedToCachedData(
    List<CategoryDashboardEntities> entities,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final chartDecoded = jsonEncode(
      entities.map((e) => e.toCachedJson()).toList(),
    );
    await prefs.setString(chartCached, chartDecoded);
  }
}
