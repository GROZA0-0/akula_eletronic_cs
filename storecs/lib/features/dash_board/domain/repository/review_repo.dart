import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';

abstract class ReviewRepo {
  Stream<List<ReviewEntities>> get reviewStream;
  Future<List<ReviewEntities>> reviewRepository();
}
