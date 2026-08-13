import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class GetFeedbackEnitities extends Equatable {
  String? id;
  final String empEmail;
  final String issue;
  final String severity;
  String? note;

  GetFeedbackEnitities({
    this.id,
    required this.empEmail,
    required this.issue,
    required this.severity,
    this.note,
  });

  @override
  List<Object?> get props => [id, empEmail, issue, severity, note];
}
