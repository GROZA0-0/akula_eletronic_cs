import 'package:equatable/equatable.dart';
import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';

abstract class ExportReportsBlocEvent extends Equatable {}

class TriggerExportEvent extends ExportReportsBlocEvent {
  final ExportReportsModel reportsModel;
  TriggerExportEvent({required this.reportsModel});

  @override
  List<Object?> get props => [reportsModel];
}

class PreviewExportEvent extends ExportReportsBlocEvent {
  final ExportReportsModel reportsModel;
  PreviewExportEvent({required this.reportsModel});

  @override
  List<Object?> get props => [reportsModel];
}

class ExportReportsBlocEventLoading extends ExportReportsBlocEvent {
  @override
  List<Object?> get props => [];
}

class ExportReportsBlocEventError extends ExportReportsBlocEvent {
  final String err;
  ExportReportsBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
