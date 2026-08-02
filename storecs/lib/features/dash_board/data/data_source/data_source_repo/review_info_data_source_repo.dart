import 'package:storecs/features/dash_board/data/model/review_model.dart';

abstract class ReviewInfoDataSourceRepo {
  Future<List<ReviewModel>> togetReviewDataSourceRepo();
}
