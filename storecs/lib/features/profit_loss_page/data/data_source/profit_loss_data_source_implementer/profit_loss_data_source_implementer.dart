import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/profit_loss_page/data/data_source/profit_loss_data_source_repository/profit_loss_data_source_repository.dart';
import 'package:storecs/features/profit_loss_page/data/model/profit_loss_model.dart';

class ProfitLossDataSourceImplementer
    implements ProfitLossDataSourceRepository {
  final Dio dio;
  ProfitLossDataSourceImplementer({required this.dio});

  @override
  Future<ProfitLossModel> storeProfitLossDataSourceRepo(
    String orderId,
    String orderType,
    double totalPrice,
  ) async {
    final storeProfitLossCase =
        '${Env.baseURL}storePurchaseOrRefundOrderDetailsRoute';
    final data = {
      "orderId": orderId,
      "orderType": orderType,

      "totalPrice": totalPrice,
    };
    final res = await dio.post(
      storeProfitLossCase,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return ProfitLossModel.emptyProfitLossModel();
      } else {
        final data = res.data['data'];
        return ProfitLossModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating Profit/Loss case ? : ${res.statusCode}",
      );
    }
  }

  @override
  Future<List<ProfitLossModel>> getProfitLossLogsDataSourceRepo() async {
    final getLogs = '${Env.baseURL}getAllProfitLossLogs';
    final res = await dio.get(
      getLogs,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return [];
      } else {
        final List data = res.data['data'];
        return data.map((e) => ProfitLossModel.fromJson(e)).toList();
      }
    } else {
      throw Exception(
        "Any issue with fetching Profit/Loss logs ? : ${res.statusCode}",
      );
    }
  }
}
