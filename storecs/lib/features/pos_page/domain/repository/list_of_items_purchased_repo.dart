import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';

abstract class ListOfItemsPurchasedRepo {
  Future<ListOfItemsPurchasedEntities> toListOfItemsPurchasedEntities(
    String orderId,
    List<CartEntities> items,
    double totalPrice,
  );
}
