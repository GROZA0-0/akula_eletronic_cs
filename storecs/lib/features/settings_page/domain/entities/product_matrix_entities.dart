import 'package:equatable/equatable.dart';

class ProductMatrixEntities extends Equatable {
  final String? id;
  final String name;
  final String brand;
  final String category;
  final String image;
  final String description;
  final double price;

  const ProductMatrixEntities({
    this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  List<Object?> get props => [id,name,brand,category,image,description,price];
}
