import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class FeedbackEntities extends Equatable {
  final String empId;
  final String empEmail;
  final String issue;
  final String severity;
  String? note;
  FeedbackEntities({
    required this.empId,
    required this.empEmail,
    required this.issue,
    required this.severity,
    this.note,
  });

  @override
  List<Object?> get props => [empId, empEmail, issue, severity, note];
}
