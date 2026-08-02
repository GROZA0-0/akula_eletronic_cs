import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/category_dashboard_data_source_repo.dart';
import 'package:storecs/features/dash_board/data/model/category_dashboard_model.dart';

class CategoryDashboardDataSourceImplementer
    implements CategoryDashboardDataSourceRepo {
  final Dio dio;
  CategoryDashboardDataSourceImplementer({required this.dio});

  @override
  Future<List<CategoryDashboardModel>> getCategoryAvgSales() async {
    final getChart = '${Env.baseURL}getCategoryAvgSalesRoute';
    final res = await dio.get(getChart);
    if (res.statusCode == 200) {
      if (res.data == null) {
        return [];
      } else {
        final List data = res.data['data'];
        return data.map((e) => CategoryDashboardModel.fromJson(e)).toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching chart info  Server Error: ${res.statusCode}",
      );
    }
  }
}
