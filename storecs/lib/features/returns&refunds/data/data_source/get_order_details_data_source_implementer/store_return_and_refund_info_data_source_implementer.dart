import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/returns&refunds/data/data_source/get_order_details_data_source_repository/store_return_and_refund_info_data_source_repository.dart';
import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/data/models/store_the_refund_info_model.dart';

class StoreReturnAndRefundInfoDataSourceImplementer
    implements StoreReturnAndRefundInfoDataSourceRepository {
  final Dio dio;
  StoreReturnAndRefundInfoDataSourceImplementer({required this.dio});

  @override
  Future<StoreTheRefundInfoModel> toStoreTheRefundInfoRepo(
    String orderId,
    bool restoreInventory,
    String refundReason,
    double totalRefundAmount,
    List<RefundItemModel> item,
  ) async {
    final storeRefund = '${Env.baseURL}storeReturnAndRefundInfoRoute';
    final Map<String, dynamic> info = {
      'orderId': orderId,
      'restoreInventory': restoreInventory,
      'refundReason': refundReason,
      'totalRefundAmount': totalRefundAmount,
      'items': item.map((e) => e.toJson()).toList(),
    };
    final res = await dio.post(
      storeRefund,
      data: info,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return StoreTheRefundInfoModel.emptyRefund();
      } else {
        Map<String, dynamic> data = res.data;
        return StoreTheRefundInfoModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating refund info ? : ${res.statusCode}",
      );
    }
  }
}
