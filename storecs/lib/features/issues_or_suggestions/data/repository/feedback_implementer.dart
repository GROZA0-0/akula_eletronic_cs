import 'package:storecs/features/issues_or_suggestions/data/data_source/feedback_data_source_repo/feedback_data_source_repo.dart';
import 'package:storecs/features/issues_or_suggestions/domain/entities/feedback_entities.dart';
import 'package:storecs/features/issues_or_suggestions/domain/repository/feedback_repository.dart';

class FeedbackImplementer implements FeedbackRepository {
  final FeedbackDataSourceRepo repo;
  FeedbackImplementer(this.repo);

  @override
  Future<FeedbackEntities> storeFeedbackEntities(
    String empId,
    String empEmail,
    String issue,
    String severity,
    String note,
  ) async {
    try {
      final model = await repo.storeReport(
        empId,
        empEmail,
        issue,
        severity,
        note,
      );
      return model.toFeedbackEntities();
    } catch (e) {
      print("any errors in FeedbackImplementer $e");
      throw e.toString();
    }
  }
}
