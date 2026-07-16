import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/get_order_details_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/models/order_details_model.dart';

class GetOrderDetailsDataSourceImplementer
    implements GetOrderDetailsDataSourceRepository {
  final Dio dio;
  GetOrderDetailsDataSourceImplementer({required this.dio});

  @override
  Future<OrderDetailsModel> searchByOrderId(String orderId) async {
    final getOrder = "${Env.baseURL}searchByOrderIdRoute/$orderId";
    final res = await dio.get(getOrder);
    print('order searched $orderId');
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return OrderDetailsModel.emptyOrderData();
      } else {
        final info = res.data;
        return OrderDetailsModel.fromJson(info);
      }
    } else {
      throw Exception(
        "Any issue with fetching orders details for refunds Server Error: ${res.statusCode}",
      );
    }
  }
}
