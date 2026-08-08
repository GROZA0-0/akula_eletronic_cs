import 'package:storecs/features/issues_or_suggestions/data/model/feedback_model.dart';

abstract class FeedbackDataSourceRepo {
  Future<FeedbackModel> storeReport(
    String empId,
    String empEmail,
    String issue,
    String severity,
    String note,
  );
}
