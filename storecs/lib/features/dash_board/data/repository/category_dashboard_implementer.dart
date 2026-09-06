import 'package:rxdart/rxdart.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/category_dashboard_data_source_repo.dart';
import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/category_dashboard_repo.dart';

class CategoryDashboardImplementer implements CategoryDashboardRepo {
  final CategoryDashboardDataSourceRepo sourceRepo;
  CategoryDashboardImplementer({required this.sourceRepo});

  final controller = BehaviorSubject<List<CategoryDashboardEntities>>();

  @override
  Future<List<CategoryDashboardEntities>> getChartRepo() async {
    try {
      final model = await sourceRepo.getCategoryAvgSales();
      final entity = model.map((e) => e.toCategoryDashboardEntities()).toList();
      controller.add(entity);
      return entity;
    } catch (e) {
      print("any errors in CategoryDashboardImplementer $e");
      throw e.toString();
    }
  }

  @override
  Stream<List<CategoryDashboardEntities>> get getChart => controller.stream;
}
