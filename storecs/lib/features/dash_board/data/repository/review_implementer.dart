import 'package:storecs/features/dash_board/data/data_source/data_source_repo/review_info_data_source_repo.dart';
import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';
import 'package:storecs/features/dash_board/domain/repository/review_repo.dart';

class ReviewImplementer implements ReviewRepo {
  final ReviewInfoDataSourceRepo reviewInfoDataSourceRepo;
  ReviewImplementer({required this.reviewInfoDataSourceRepo});

  @override
  Future<List<ReviewEntities>> reviewRepository() async {
    try {
      final model = await reviewInfoDataSourceRepo.togetReviewDataSourceRepo();
      return model.map((e) => e.toReviewEntities()).toList();
    } catch (e) {
      print("any errors in ReviewImplementer $e");
      throw e.toString();
    }
  }
}
