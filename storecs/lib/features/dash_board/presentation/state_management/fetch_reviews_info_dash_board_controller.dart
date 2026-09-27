import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';

class FetchReviewsInfoDashBoardController {
  final ReviewRepo repo;
  FetchReviewsInfoDashBoardController({required this.repo});

  ReviewEntities entities = ReviewEntities(items: [], totalPrice: 0.0);
  Stream<List<ReviewEntities>> getReviews() {
    try {
      repo.reviewRepository().catchError((e) {
        print("Background fetch failed: $e");
        return [ReviewEntities.emptyReviewEntities()];
      });
      return repo.reviewStream;
    } catch (e) {
      print("error in reviews dashboard controller $e");
      throw e.toString();
    }
  }

  Future<void> loadCachedData() async {
    await repo.reviewInfoLoadCachedData();
  }
}
