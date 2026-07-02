import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';

class POSModel {
  final String id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String barcode;
  final String description;
  final String price;
  final String costPrice;
  final String stock;

  POSModel({
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

  Map<String, dynamic> toJson() => {
    "pId": id,
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

  static POSModel posEmptyData() {
    return POSModel(
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

  factory POSModel.fromPOSSnapshot(Map<String, dynamic> map) {
    return POSModel(
      id: map['pId'].toString(),
      name: map['pName'].toString(),
      brand: map['pBrand'].toString(),
      category: map['category'].toString(),
      image: map['pImage'].toString(),
      barcode: map['pBarcode'].toString(),
      description: map['pDescription'].toString(),
      price: map['pPrice'].toString(),
      costPrice: map['pCostPrice'].toString(),
      stock: map['pStock'].toString(),
    );
  }

  PosEntities toPosEntities() {
    return PosEntities(
      id: id,
      name: name,
      brand: brand,
      category: category,
      image: image,
      barcode: barcode,
      description: description,
      price: price,
      stock: stock,
    );
  }
}
