import 'package:equatable/equatable.dart';

abstract class DashboardBlocEvent extends Equatable {}

class DashboardBlocEventLoading extends DashboardBlocEvent {
  @override
  List<Object?> get props => [];
}

class DashboardBlocEventError extends DashboardBlocEvent {
  final String err;
  DashboardBlocEventError({required this.err});
  @override
  List<Object?> get props => [err];
}
