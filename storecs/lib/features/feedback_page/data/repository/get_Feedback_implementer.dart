import 'package:storecs/features/feedback_page/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';
import 'package:storecs/features/feedback_page/domain/repository/get_feedback_repo.dart';

class GetFeedbackImplementer implements GetFeedbackRepo {
  final GetFeedbackDataSourceRepo sourceRepo;
  GetFeedbackImplementer({required this.sourceRepo});

  @override
  Future<List<GetFeedbackEnitities>> getListFeedbackRepo() async {
    try {
      final model = await sourceRepo.getListFeedbackDataSourceRepo();
      return model.map((e) => e.toFeedbackEnitities()).toList();
    } catch (e) {
      print("any errors in GetFeedbackImplementer $e");
      throw e.toString();
    }
  }
}
