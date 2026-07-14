class OrderPurchasedHistoryItemsDetails {
  final String id;
  final String name;
  final String brand;
  final String image;
  double price;
  final int stock;
  final int quantity;

  OrderPurchasedHistoryItemsDetails({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.stock,
    int initialQuantity = 1,
  }) : quantity = initialQuantity;
  double get totalPrice => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "pName": name,
      "pBrand": brand,

      "pImage": image,

      "pPrice": price,

      "pStock": stock,
      "quantity": quantity,
    };
  }

  factory OrderPurchasedHistoryItemsDetails.fromJson(Map<String, dynamic> map) {
    return OrderPurchasedHistoryItemsDetails(
      id: map['_id'].toString(),
      name: map['pName'] ?? '',
      brand: map['pBrand'] ?? "",

      image: map['pImage'] ?? '',

      price: (map['pPrice'] as num).toDouble(),

      stock: (map['pStock'] as num).toInt(),
      initialQuantity: (map['quantity'] as num).toInt(),
    );
  }
}
