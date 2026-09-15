import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/stocks_alert_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/stock_alerts_model/low_stock_item_model.dart';

class StocksAlertDataSourceImplementer implements StocksAlertDataSourceRepo {
  final Dio dio;
  StocksAlertDataSourceImplementer({required this.dio});

  @override
  Future<void> saveStockThresholdsDataSourceRepository(
    Map<String, int> threshold,
  ) async {
    final storeThre = '${Env.baseURL}saveStockThresholdsRoute';
    final data = {'threshold': threshold};
    final res = await dio.post(
      storeThre,
      data: data,
      options: Options(validateStatus: (status) => status! < 600),
    );
    if (res.statusCode != 201) {
      throw Exception('Failed to save thresholds: ${res.statusCode}');
    }
  }

  @override
  Future<List<LowStockItemModel>> getLowStockItemsDataSourceRepository() async {
    final getLowStocks = '${Env.baseURL}getLowStockItemsRoute';
    final res = await dio.get(
      getLowStocks,
      options: Options(validateStatus: (status) => status! < 600),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final rawData = res.data is Map ? res.data['data'] : res.data;
      if (rawData is List) {
        return rawData
            .whereType<Map<String, dynamic>>()
            .map((item) => LowStockItemModel.fromJosn(item))
            .toList();
      }
      return [];
    } else {
      throw Exception('Failed to get Low Stock: ${res.statusCode}');
    }
  }

  @override
  Future<Map<String, int>> getStockThresholdsDataSourceRepository() async {
    final getThre = '${Env.baseURL}getStockThresholdsRoute';
    final res = await dio.get(
      getThre,
      options: Options(validateStatus: (status) => status! < 600),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      final rawData = res.data['data'];
      if (rawData is List) {
        final Map<String, int> resultMap = {};
        for (final result in rawData) {
          if (result is Map<String, dynamic>) {
            resultMap[result['category'].toString()] =
                (result['threshold'] as num).toInt();
          }
        }
        return resultMap;
      }
      /* Convert Map<String, dynamic> -> Map<String, int> */
      if (rawData is Map) {
        return rawData.map(
          (key, value) => MapEntry(key, (value as num).toInt()),
        );
      }
      return {};
    } else {
      throw Exception('Failed to get thresholds: ${res.statusCode}');
    }
  }
}
