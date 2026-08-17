import 'package:equatable/equatable.dart';

abstract class ExportReportsBlocState extends Equatable {}

class ExportReportsBlocStateInitial extends ExportReportsBlocState {
  @override
  List<Object?> get props => [];
}

class ExportReportsBlocStateLoading extends ExportReportsBlocState {
  @override
  List<Object?> get props => [];
}

class ExportReportsBlocStatePreviewed extends ExportReportsBlocState {
  final List<Map<String, dynamic>> items;
  ExportReportsBlocStatePreviewed({required this.items});

  @override
  List<Object?> get props => [items];
}

class ExportReportsBlocStateLoaded extends ExportReportsBlocState {
  final String filePath;
  ExportReportsBlocStateLoaded({required this.filePath});

  @override
  List<Object?> get props => [filePath];
}

class ExportReportsBlocStateError extends ExportReportsBlocState {
  final String err;
  ExportReportsBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
