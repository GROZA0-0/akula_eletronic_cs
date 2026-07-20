import 'package:equatable/equatable.dart';

class ReportEntities extends Equatable {
  final String id;
  final String empId;
  final String email;
  final String level;
  final String reportTitle;
  final String reportSubTitle;
  const ReportEntities({
    required this.id,
    required this.empId,
    required this.email,
    required this.level,
    required this.reportTitle,
    required this.reportSubTitle,
  });
  @override
  List<Object?> get props => [
    id,
    empId,
    email,
    level,
    reportTitle,
    reportSubTitle,
  ];
}
