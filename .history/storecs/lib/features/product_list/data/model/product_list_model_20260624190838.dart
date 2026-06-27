import 'package:storecs/features/product_list/domain/entities/product_list_entities.dart';

class ProductListModel {
  final String? id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String barcode;
  final String description;
  final String price;
  final String costPrice;
  final String stock;
  ProductListModel({
    this.id,
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
      "_id": id,
      "pName": name,
      "pBrand": brand,
      "pCategory": category,
      "pImage": image,
      "pBarcode": barcode,
      "pDescription": description,
      "pPrice": price,
      "pCostPrice": costPrice,
      "pStock": stock,
    };
  }

  static ProductListModel emptyProductMap() {
    return ProductListModel(
      id: '',
      name: '',
      brand: '',
      category: '',
      image: '',
      barcode: '',
      description: '',
      price: '',
      costPrice: '',
      stock: '',
    );
  }

  factory ProductListModel.fromProductSnapShot(Map<String, dynamic> map) {
    return ProductListModel(
      id: map['_id']?.toString(),
      name: map['pName'] ?? '',
      brand: map['pBrand'] ?? "",
      category: map['pCategory'] ?? '',
      image: map['pImage'] ?? '',
      barcode: map['pBarcode'] ?? '',
      description: map['pDescription'] ?? '',
      price: map['pPrice'] ?? '',
      costPrice: map['pCostPrice'] ?? '',
      stock: map['pStock'] ?? '',
    );
  }
  InsertProductListEntities toInsertProductListEntities() {
    return InsertProductListEntities(
      id: id ?? '',
      name: name,
      brand: brand,
      category: category,
      image: image,
      barcode: barcode,
      description: description,
      price: price,
      costPrice: costPrice,
      stock: stock,
    );
  }
}
