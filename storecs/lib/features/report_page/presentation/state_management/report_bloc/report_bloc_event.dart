import 'package:equatable/equatable.dart';

abstract class ReportBlocEvent extends Equatable {}

class ReportBlocEventLoading extends ReportBlocEvent {
  @override
  List<Object?> get props => [];
}

class ReportBlocEventError extends ReportBlocEvent {
  final String err;
  ReportBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
