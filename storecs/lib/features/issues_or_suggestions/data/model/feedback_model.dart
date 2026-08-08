import 'package:storecs/features/issues_or_suggestions/domain/entities/feedback_entities.dart';

class FeedbackModel {
  String? id;
  final String empId;
  final String empEmail;
  final String issue;
  final String severity;
  String? note;
  final DateTime createdAt;

  FeedbackModel({
    this.id,
    required this.empId,
    required this.empEmail,
    required this.issue,
    required this.severity,
    this.note,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "empId": empId,
      "empEmail": empEmail,
      "issue": issue,
      "severity": severity,
      "note": note,
    };
  }

  static FeedbackModel emptyFeedback() {
    return FeedbackModel(
      id: '',
      empEmail: '',
      issue: '',
      severity: '',
      createdAt: DateTime.now(),
      empId: '',
    );
  }

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['_id'] ?? '',
      empId: json['empId'] ?? '',
      empEmail: json['empEmail'] ?? '',
      issue: json['issue'] ?? '',
      severity: json['severity'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }

  FeedbackEntities toFeedbackEntities() {
    return FeedbackEntities(
      empId: empId,
      empEmail: empEmail,
      issue: issue,
      severity: severity,
    );
  }
}
