import 'package:equatable/equatable.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';

abstract class ReportBlocState extends Equatable {}

class ReportBlocStateLoading extends ReportBlocState {
  @override
  List<Object?> get props => [];
}

class ReportBlocStateLoaded extends ReportBlocState {
  final GetReportOfSupervisorEntities entities;
  ReportBlocStateLoaded({required this.entities});

  @override
  List<Object?> get props => [entities];
}

class ReportBlocStateError extends ReportBlocState {
  final String err;
  ReportBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
