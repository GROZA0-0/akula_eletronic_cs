import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';
import 'package:storecs/features/feedback_page/domain/repository/get_feedback_repo.dart';

class GetFeedbackController {
  final GetFeedbackRepo repo;
  GetFeedbackController({required this.repo});

  List<GetFeedbackEnitities> entities = [];

  Future<List<GetFeedbackEnitities>> getFeedbacks() async {
    try {
      final feedbackList = await repo.getListFeedbackRepo();
      entities = feedbackList.toList();
      return feedbackList;
    } catch (e) {
      print("error in GetFeedbackList controller $e");
      throw e.toString();
    }
  }
}
