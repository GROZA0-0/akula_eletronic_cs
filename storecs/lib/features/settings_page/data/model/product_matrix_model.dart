import 'package:storecs/features/settings_page/domain/entities/product_matrix_entities.dart';

class ProductMatrixModel {
  final String? id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String description;
  final double price;

  ProductMatrixModel({
    this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
  });

  static ProductMatrixModel emptyProductMatrixModel() {
    return ProductMatrixModel(
      id: '',
      name: '',
      brand: '',
      category: '',
      image: '',
      price: 0.0,
      description: '',
    );
  }

  factory ProductMatrixModel.fromJson(Map<String, dynamic> map) {
    /* print('from mongo ${map['pBrand']}'); */
    return ProductMatrixModel(
      id: map['_id'].toString(),
      name: map['pName'] ?? '',
      brand: map['pBrand'] ?? '',
      category: map['pCategory'] ?? '',
      image: map['pImage'] ?? '',
      price: (map['pPrice'] is num) ? (map['pPrice'] as num).toDouble() : 0.0,
      description: map['pDescription'] ?? '',
    );
  }

  ProductMatrixEntities toProductMatrixEntities() {
    return ProductMatrixEntities(
      name: name,
      brand: brand,
      category: category,
      image: image,
      price: price,
      description: description,
    );
  }
}
