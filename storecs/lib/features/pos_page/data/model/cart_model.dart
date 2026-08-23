import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';
import 'package:storecs/features/pos_page/domain/enitities/list_of_items_purchased_entities.dart';

class CartModel {
  final String orderId;
  final List<CartEntities> items;
  final String fullName;

  final double totalPrice;

  DateTime? createdAt;

  CartModel({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    required this.fullName,
    this.createdAt,
  });

  Map<String, dynamic> toJosn() {
    return {
      'orderId': orderId,
      'items': items.map((e) => e.toJson()).toList(),
      'sold_by':fullName,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
    };
  }

  static CartModel storeEmpty() {
    return CartModel(orderId: '', items: [], totalPrice: 0.0,fullName: '');
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
          id: item['id']?.toString() ?? item['_id']?.toString() ?? '',

          name: item['pName'] ?? item['name'] ?? '',
          category: item['pCategory'] ?? item['pCategory'] ?? '',

          brand: item['pBrand'] ?? item['brand'] ?? '',

          image: item['pImage'] ?? item['image'] ?? '',

          price:
              (item['pPrice'] as num?)?.toDouble() ??
              (item['price'] as num?)?.toDouble() ??
              0.0,

          stock:
              (item['pStock'] as num?)?.toInt() ??
              (item['stock'] as num?)?.toInt() ??
              0,

          initialQuantity: (item['quantity'] as num?)?.toInt() ?? 1,
        );
      }).toList(),
      fullName: json['sold_by']??''
    );
  }

  ListOfItemsPurchasedEntities toListOfItemsPurchasedEntities() {
    return ListOfItemsPurchasedEntities(
      orderId: orderId,
      items: items,
      totalPrice: totalPrice,fullName: fullName
    );
  }
}
