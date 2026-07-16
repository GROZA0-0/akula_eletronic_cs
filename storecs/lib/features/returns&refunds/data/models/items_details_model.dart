class ItemsDetailsModel {
  final String id;
  final String name;
  final String brand;
  final String image;
  double price;
  final int stock;
  final int quantity;
  var isSelected = false;
  var returnQuantity = 0;

  ItemsDetailsModel({
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

  factory ItemsDetailsModel.fromJson(Map<String, dynamic> map) {
    return ItemsDetailsModel(
      id: map['_id'].toString(),
      name: map['pName'] ?? '',
      brand: map['pBrand'] ?? "",

      image: map['pImage'] ?? '',

      price: (map['pPrice'] ?? 0.0).toDouble(),

      stock: (map['pStock'] ?? 0).toInt(),
      initialQuantity: (map['quantity'] ?? 1).toInt(),
    );
  }
}
