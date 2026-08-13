import 'package:storecs/features/feedback_page/data/model/feedback_model.dart';

abstract class GetFeedbackDataSourceRepo {
  Future<List<GetFeedbackModel>> getListFeedbackDataSourceRepo();
}
