import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/domain/repository/list_of_items_purchased_repo.dart';
import 'package:storecs/main.dart';

class CartController extends GetxController {
  final ListOfItemsPurchasedRepo repo;
  CartController({required this.repo});
  final RxList<CartEntities> cartItems = <CartEntities>[].obs;
  final double taxRate = 0.16;
  double get subTotal =>
      cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get taxAmount => subTotal * taxRate;
  double get total => subTotal + taxAmount;
  int get totalItems =>
      cartItems.fold(0, (sum, item) => sum + item.quantity.value);
  ListOfItemsPurchasedEntities? purchasedReceipt;
  final Alerts alerts = Alerts(messengerKey);
  final TextEditingController controller = TextEditingController();
  void addToCart(PosEntities entities) {
    /*  print('Adding product ID: ${entities.id}');
    print(
      'Cart items: ${cartItems.map((e) => '${e.id} - ${e.name}').toList()}',
    ); */
    final existItem = cartItems.indexWhere(
      (element) => element.id == entities.id,
    );
    if (existItem != -1) {
      cartItems[existItem].quantity.value++;
      cartItems.refresh();
    } else {
      cartItems.add(
        CartEntities(
          id: entities.id,
          name: entities.name,
          category: entities.category,
          brand: entities.brand,
          image: entities.image,
          price: entities.price.toDouble(),
          stock: entities.stock,
          initialQuantity: 1,
        ),
      );
      alerts.ifSuccess('Product has been added successfully');
      // print('Added to cart: ${entities.name}');
    }
  }

  void removeItem(String id) {
    cartItems.removeWhere((element) => element.id == id);
  }

  void increaseQty(String id) {
    final index = cartItems.indexWhere((element) => element.id == id);
    if (index != -1) {
      if (cartItems[index].quantity.value < cartItems[index].stock) {
        /* use to check if the qty selection reached the limit of stocks or not  */
        cartItems[index].quantity.value++;
        cartItems.refresh();
      } else {
        alerts.ifErrors('No more stock available!');
      }
    }
  }

  void decreaseQty(String id) {
    final index = cartItems.indexWhere((element) => element.id == id);
    if (index != -1) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity.value--;
        cartItems.refresh();
      }
    }
  }

  void clearCart() {
    cartItems.clear();
    print('✅ Cart cleared');
  }

  Future<void> purchase() async {
    if (cartItems.isEmpty) {
      alerts.ifErrors("Cart Is Empty.");
      return;
    }
    Loader.startLoading();
    try {
      final result = await repo.toListOfItemsPurchasedEntities(
        cartItems,
        total,
      );
      print(
        "Sending ${cartItems.length} items with order ID: '${controller.text}'",
      );
      purchasedReceipt = result;
      cartItems.clear();
      alerts.ifSuccess('Purchase Successfully');
    } on PlatformException catch (e) {
      print('The Error Is: ${e.message.toString()}');
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } catch (e) {
      Loader.stopLoading();
      print("Something went wrong. $e");
      alerts.ifErrors("Something went wrong.");
    } finally {
      Loader.stopLoading();
    }
  }

  Future<void> fetchReceipt(String orderId) async {
    try {
      final result = await repo.toGetReceiptRepo(orderId);
      purchasedReceipt = result;
    } on PlatformException catch (e) {
      print('The Error Is: ${e.message.toString()}');
      alerts.ifErrors(e.message.toString());
      Loader.stopLoading();
    } catch (e) {
      Loader.stopLoading();
      print("Something went wrong. $e");
      alerts.ifErrors("Something went wrong.");
    } finally {
      Loader.stopLoading();
    }
  }
}
