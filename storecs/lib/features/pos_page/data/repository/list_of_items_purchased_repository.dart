import 'package:storecs/features/pos_page/data/data_source/data_sorce_repo/list_of_items_purchased_data_source_repo.dart';

import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';
import 'package:storecs/features/pos_page/domain/repository/list_of_items_purchased_repo.dart';

class ListOfItemsPurchasedRepository implements ListOfItemsPurchasedRepo {
  final ListOfItemsPurchasedDataSourceRepo implementer;
  ListOfItemsPurchasedRepository({required this.implementer});
  @override
  Future<ListOfItemsPurchasedEntities> toListOfItemsPurchasedEntities(
    String orderId,
    List<CartEntities> items,
    double totalPrice,
  ) async {
    try {
      final data = await implementer.toListOfItemsPurchasedDataSourceRepo(
        orderId,
        items,
        totalPrice,
      );
      return data.toListOfItemsPurchasedEntities();
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }
}
