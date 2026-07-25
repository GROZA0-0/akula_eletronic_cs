import 'package:storecs/features/pos_page/data/model/cart_model.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

abstract class ListOfItemsPurchasedDataSourceRepo {
  Future<CartModel> toListOfItemsPurchasedDataSourceRepo(
    List<CartEntities> items,
    double totalPrice,
  );
  Future<CartModel> toGetNewestReceipt(String orderId);
}
