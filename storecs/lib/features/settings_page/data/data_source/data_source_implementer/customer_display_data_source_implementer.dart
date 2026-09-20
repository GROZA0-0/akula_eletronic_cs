import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/customer_display_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/customer_display_model.dart';

class CustomerDisplayDataSourceImplementer
    implements CustomerDisplayDataSourceRepo {
  final Dio dio;
  CustomerDisplayDataSourceImplementer({required this.dio});

  @override
  Future<CustomerDisplayModel> getCustomerDisplayDataSourceRepo() async {
    final getFace = '${Env.baseURL}getCustomerDisplayRoute';
    final res = await dio.get(
      getFace,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      if (res.data == null) {
        return CustomerDisplayModel.emptyCustomerDisplayModel();
      } else {
        final data = res.data['data'];
        return CustomerDisplayModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching customer display ? : ${res.statusCode}",
      );
    }
  }

  @override
  Future<void> storeCustomerDisplayDataSourceRepo(
    Map<String, bool> customerDisplaySchema,
    Map<String, bool> showLiveTotals,
    Map<String, bool> showItemList,
    Map<String, bool> showPromotionalImages,
    Map<String, bool> requireDigitalSignature,
    Map<String, bool> showThankYouScreen,
    String idleScreenOptions,
  ) async {
    final storeFace = '${Env.baseURL}storeCustomerDisplayRoute';
    final data = {
      "customerDisplaySchema": customerDisplaySchema,
      "showLiveTotals": showLiveTotals,
      "showItemList": showItemList,
      "showPromotionalImages": showPromotionalImages,
      "requireDigitalSignature": requireDigitalSignature,
      "showThankYouScreen": showThankYouScreen,
      "idleScreenOptions": idleScreenOptions,
    };
    final res = await dio.post(
      storeFace,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 201) {
      if (res.data == null) {
        CustomerDisplayModel.emptyCustomerDisplayModel();
      } else {
        final data = res.data['data'];
        CustomerDisplayModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating customer display ? : ${res.statusCode}",
      );
    }
  }
}
