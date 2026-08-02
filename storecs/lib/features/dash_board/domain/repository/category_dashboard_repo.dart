import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';

abstract class CategoryDashboardRepo {
  Future<List<CategoryDashboardEntities>> getChartRepo();
}
