import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';

class FetchReviewsInfoDashBoardController {
  final ReviewRepo repo;
  FetchReviewsInfoDashBoardController({required this.repo});

  ReviewEntities entities = ReviewEntities(items: [], totalPrice: 0.0);
  Stream<List<ReviewEntities>> getReviews() async* {
    try {
      final reviews = await repo.reviewRepository();
      yield reviews;
      await for (final _ in repo.reviewStream) {
        final updateReview = await repo.reviewRepository();
        yield updateReview;
      }
    } catch (e) {
      print("error in reviews dashboard controller $e");
      throw e.toString();
    }
  }
}
