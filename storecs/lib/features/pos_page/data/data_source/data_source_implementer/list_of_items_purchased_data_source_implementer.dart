import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/list_of_items_purchased_data_source_repo.dart';
import 'package:storecs/features/pos_page/data/model/cart_model.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

class ListOfItemsPurchasedDataSourceImplementer
    implements ListOfItemsPurchasedDataSourceRepo {
  final Dio dio;
  ListOfItemsPurchasedDataSourceImplementer({required this.dio});

  @override
  Future<CartModel> toListOfItemsPurchasedDataSourceRepo(
    String orderId,
    List<CartEntities> items,
    double totalPrice,
  ) async {
    final storeOrder = '${Env.baseURL}insertOrderToDatabaseController';
    final Map<String, dynamic> body = {
      'orderId': orderId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
    };
    final res = await dio.post(
      storeOrder,
      data: body,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return CartModel.storeEmpty();
      } else {
        final orderData = res.data;
        return CartModel.fromJson(orderData);
      }
    } else {
      throw Exception("Any issue with creating order ? : ${res.statusCode}");
    }
  }
}
