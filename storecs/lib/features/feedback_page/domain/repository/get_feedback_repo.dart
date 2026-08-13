import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';

abstract class GetFeedbackRepo {
  Future<List<GetFeedbackEnitities>> getListFeedbackRepo();
}
