import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';

abstract class ReviewRepo {
  Future<List<ReviewEntities>> reviewRepository();
}
