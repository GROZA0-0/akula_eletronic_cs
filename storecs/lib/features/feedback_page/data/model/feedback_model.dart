import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';

class GetFeedbackModel {
  String? id;
  final String empEmail;
  final String issue;
  final String severity;
  String? note;
  final DateTime createdAt;

  GetFeedbackModel({
    this.id,
    required this.empEmail,
    required this.issue,
    required this.severity,
    this.note,
    required this.createdAt,
  });

  static GetFeedbackModel emptyFeedback() {
    return GetFeedbackModel(
      id: '',
      empEmail: '',
      issue: '',
      severity: '',
      note: '',
      createdAt: DateTime.now(),
    );
  }

  factory GetFeedbackModel.fromJson(Map<String, dynamic> json) {
    return GetFeedbackModel(
      id: json['_id'],
      empEmail: json['empEmail'] ?? '',
      issue: json['issue'] ?? '',
      severity: json['severity'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  GetFeedbackEnitities toFeedbackEnitities() {
    return GetFeedbackEnitities(
      id: id,
      empEmail: empEmail,
      issue: issue,
      severity: severity,
      note: note,
    );
  }
}
