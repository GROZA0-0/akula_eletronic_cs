import 'package:storecs/features/pos_page/data/model/cart_model.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

abstract class ListOfItemsPurchasedDataSourceRepo {
  Future<CartModel> toListOfItemsPurchasedDataSourceRepo(
    String orderId,
    List<CartEntities> items,
    double totalPrice,
  );
}
