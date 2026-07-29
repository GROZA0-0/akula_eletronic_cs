import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

@immutable
// ignore: must_be_immutable
class CartEntities extends Equatable {
  final String id;
  final String name;
  final String brand;
  final String image;
  double price;
  final int stock;
  final RxInt quantity;

  CartEntities({
    required this.id,
    required this.name,
    required this.brand,
    required this.image,
    required this.price,
    required this.stock,
    int initialQuantity = 1,
  }) : quantity = initialQuantity.obs;
  double get totalPrice => price * quantity.value;

  @override
  List<Object?> get props => [id, name, brand, image, price, quantity];

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pName': name,
      'pBrand':brand,
      'pImage': image,
      'pPrice': price,
      'pStock': stock,
      'quantity': quantity.value,
      'totalPrice': totalPrice,
    };
  }
}
