import 'package:equatable/equatable.dart';

abstract class ReportBlocEvent extends Equatable {}

class ReportBlocEventLoading extends ReportBlocEvent {
  final String level;
  ReportBlocEventLoading({required this.level});
  @override
  List<Object?> get props => [level];
}

class ReportBlocEventError extends ReportBlocEvent {
  final String err;
  ReportBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
