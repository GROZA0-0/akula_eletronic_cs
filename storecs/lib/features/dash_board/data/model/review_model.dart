import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';

class ReviewModel {
  final List items;
  final double totalPrice;

  ReviewModel({required this.items, required this.totalPrice});

  static ReviewModel emptyReview() {
    return ReviewModel(items: [], totalPrice: 0.0);
  }

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      items: json['items'] != null ? List.from(json['items']) : [],
      totalPrice: json['totalPrice'] ?? 0.0,
    );
  }

  ReviewEntities toReviewEntities() {
    return ReviewEntities(items: items, totalPrice: totalPrice);
  }
}
