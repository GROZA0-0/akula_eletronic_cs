import 'package:equatable/equatable.dart';

class ReviewEntities extends Equatable {
  final List items;
  final double totalPrice;
  const ReviewEntities({required this.items, required this.totalPrice});

  @override
  List<Object?> get props => [items, totalPrice];
}
