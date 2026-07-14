import 'package:equatable/equatable.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

// ignore: must_be_immutable
class ListOfItemsPurchasedEntities extends Equatable {
  final String orderId;
  final List<CartEntities> items;

  final double totalPrice;

  DateTime? createdAt;
  ListOfItemsPurchasedEntities({
    required this.orderId,
    required this.items,
    required this.totalPrice,
    this.createdAt,
  });

  @override
  List<Object?> get props => [orderId, items, totalPrice, createdAt];
}
