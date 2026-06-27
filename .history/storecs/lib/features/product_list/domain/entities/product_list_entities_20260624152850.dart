import 'package:equatable/equatable.dart';

class InsertProductListEntities extends Equatable {
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
  const InsertProductListEntities({
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
  @override
  List<Object?> get props => [
    id,
    name,
    brand,
    category,
    image,
    barcode,
    description,
    price,
    costPrice,
    stock,
  ];
}
