class ProductList {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String barcode;
  final String description;
  final double price;
  final double costPrice;
  final double stock;
  ProductList({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.barcode,
    required this.description,
    required this.price,
    required this.costPrice,
    required this.stock,
  });

  Map<String, dynamic> toJson() {
    return {
      "pId": id,
      "pName": name,
      "pBrand": brand,
      "pCategory": category,
      "pImage": image,
      "pBarcode": barcode,
      "pDescription": description,
      "pPrice": 0,
      "pCostPrice": 0,
      "pStock": 0,
    };
  }

  static ProductList emptyProductMap() {
    return ProductList(
      id: '',
      name: '',
      brand: '',
      category: '',
      image: '',
      barcode: '',
      description: '',
      price: 0,
      costPrice: 0,
      stock: 0,
    );
  }

  factory ProductList.fromProductSnapShot(Map<String, dynamic> map) {
    return ProductList(
      id: map['pId'],
      name: map['pName'],
      brand: map['pBrand'],
      category: map['pCategory'],
      image: map['pImage'],
      barcode: map['pBarcode'],
      description: map['pDescription'],
      price: map['pPrice'],
      costPrice: map['pCostPrice'],
      stock: map['pStock'],
    );
  }
}
