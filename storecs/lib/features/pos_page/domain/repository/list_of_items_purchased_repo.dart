import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';

abstract class ListOfItemsPurchasedRepo {
  Future<ListOfItemsPurchasedEntities> toListOfItemsPurchasedEntities(
    List<CartEntities> items,
    double totalPrice,
  );
  Future<ListOfItemsPurchasedEntities> toGetReceiptRepo(String orderId);
}
