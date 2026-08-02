import 'package:get/get.dart';
import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';

class FetchReviewsInfoDashBoardController extends GetxController {
  final ReviewRepo repo;
  FetchReviewsInfoDashBoardController({required this.repo});

  ReviewEntities entities = ReviewEntities(items: [], totalPrice: 0.0);
  // double totalAllOrdersPrice = 0.0;
  Future<List<ReviewEntities>> getReviews() async {
    try {
      final reviews = await repo.reviewRepository();
      /* totalAllOrdersPrice = reviews.fold<double>(
        0.0,
        (previousValue, element) => previousValue + element.totalPrice,
      ); */
      return reviews;
    } catch (e) {
      print("error in reviews dashboard controller $e");
      throw e.toString();
    }
  }
}
