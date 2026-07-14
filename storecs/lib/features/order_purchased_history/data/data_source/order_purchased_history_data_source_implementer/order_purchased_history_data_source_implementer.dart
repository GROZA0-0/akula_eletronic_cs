import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/order_purchased_history/data/data_source/order_purchased_history_data_source_repo/order_purchased_history_data_source_repo.dart';
import 'package:storecs/features/order_purchased_history/data/model/order_purchased_history_model.dart';

class OrderPurchasedHistoryDataSourceImplementer
    implements OrderPurchasedHistoryDataSourceRepo {
  final Dio dio;
  OrderPurchasedHistoryDataSourceImplementer({required this.dio});
  @override
  Future<List<OrderPurchasedHistoryModel>> soldHistorcal() async {
    final ordersSoldHis = '${Env.baseURL}getOrdersPurchasedHistoryRoute';
    final res = await dio.get(ordersSoldHis);
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null || res.data['data'] == null) {
        return [];
      } else {
        final List<dynamic> list = res.data['data'] ?? [];
        // print("Raw data list from backend: ${list.length}");
        return list
            .map((order) => OrderPurchasedHistoryModel.fromJson(order))
            .toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching orders Sold Historical Server Error: ${res.statusCode}",
      );
    }
  }
}
