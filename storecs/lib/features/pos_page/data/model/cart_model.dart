import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';

class CartModel {
  final String orderId;
  final List<CartEntities> items;

  final double totalPrice;

  DateTime? createdAt;

  CartModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    this.createdAt,
  });

  Map<String, dynamic> toJosn() {
    return {
      'orderId': orderId,
      'items': items.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'createdAt': createdAt,
    };
  }

  static CartModel storeEmpty() {
    return CartModel(orderId: '', items: [], totalPrice: 0.0);
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      orderId: json['orderId'].toString(),
      totalPrice: json['totalPrice'] ?? 0.0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      items: (json['items'] as List? ?? []).map((item) {
        return CartEntities(
          id: item['_id'],
          name: item['pName'],
          brand: item['pBrand'],
          image: item['pImage'],
          price: item['pPrice'],
          stock: item['pStock'],
          initialQuantity: item['quantity'],
        );
      }).toList(),
    );
  }

  ListOfItemsPurchasedEntities toListOfItemsPurchasedEntities() {
    return ListOfItemsPurchasedEntities(
      orderId: orderId,
      items: items,
      totalPrice: totalPrice,
    );
  }
}
