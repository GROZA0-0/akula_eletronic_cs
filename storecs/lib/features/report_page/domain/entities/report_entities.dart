import 'package:equatable/equatable.dart';

class ReportEntities extends Equatable {
  final String id;
  final String reportTitle;
  final String reportSubTitle;
  const ReportEntities({
    required this.id,
    required this.reportTitle,
    required this.reportSubTitle,
  });
  @override
  List<Object?> get props => [id, reportTitle, reportSubTitle];
}
