import 'package:equatable/equatable.dart';

class ReviewEntities extends Equatable {
  final List items;
  final double totalPrice;
  const ReviewEntities({required this.items, required this.totalPrice});

  factory ReviewEntities.fromCacheJson(Map<String, dynamic> map) {
    return ReviewEntities(
      items: map['items'] != null ? List.from(map['items']) : [],
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toCacheJson() {
    return {"items": items, "totalPrice": totalPrice};
  }

  @override
  List<Object?> get props => [items, totalPrice];
}
