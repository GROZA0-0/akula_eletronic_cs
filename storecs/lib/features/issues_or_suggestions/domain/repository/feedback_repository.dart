import 'package:storecs/features/issues_or_suggestions/domain/entities/feedback_entities.dart';

abstract class FeedbackRepository {
  Future<FeedbackEntities> storeFeedbackEntities(
    String empId,
    String empEmail,
    String issue,
    String severity,
    String note,
  );
}
