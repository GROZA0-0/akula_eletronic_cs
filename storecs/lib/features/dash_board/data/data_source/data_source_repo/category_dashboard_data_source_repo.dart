import 'package:storecs/features/dash_board/data/model/category_dashboard_model.dart';

abstract class CategoryDashboardDataSourceRepo {
  Future<List<CategoryDashboardModel>> getCategoryAvgSales();
}
