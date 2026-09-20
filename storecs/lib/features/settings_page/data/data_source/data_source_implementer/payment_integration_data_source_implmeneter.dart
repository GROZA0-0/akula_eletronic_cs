import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/payment_integration_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/payment_integration_model.dart';

class PaymentIntegrationDataSourceImplmeneter
    implements PaymentIntegrationDataSourceRepo {
  final Dio dio;
  PaymentIntegrationDataSourceImplmeneter({required this.dio});

  @override
  Future<void> storePaymentIntegrationMoudleDataSourceRepo(
    Map<String, bool> paymentMethod,
    double minimumCardPayTextField,
    String giftCardCodePrefix,
    Map<String, bool> checkoutOptions,
  ) async {
    final storePayment = '${Env.baseURL}storePaymentIntegrationMoudleRoute';
    final data = {
      "paymentMethod": paymentMethod,
      "minimumCardPayTextField": minimumCardPayTextField,
      "giftCardCodePrefix": giftCardCodePrefix,
      "checkoutOptions": checkoutOptions,
    };
    final res = await dio.post(
      storePayment,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      if (res.data == null) {
        PaymentIntegrationModel.emptyPaymentIntegrationModel();
      } else {
        final data = res.data['data'];
        PaymentIntegrationModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating payment actions ? : ${res.statusCode}",
      );
    }
  }

  @override
  Future<PaymentIntegrationModel>
  getPaymentIntegrationMoudleDataSourceRepo() async {
    final getPayment = '${Env.baseURL}getPaymentIntegrationMoudleRoute';
    final res = await dio.get(
      getPayment,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return PaymentIntegrationModel.emptyPaymentIntegrationModel();
      } else {
        final data = res.data is Map ? res.data['data'] : res.data;
        return PaymentIntegrationModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching payment actions ? : ${res.statusCode}",
      );
    }
  }
}
