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
////////////////////////////////////
////////////////////////////////////
////////////////////////////////////

abstract class CategoryChartDashboardBlocEvent extends Equatable {}

class CategoryChartDashboardBlocEventLoading
    extends CategoryChartDashboardBlocEvent {
  @override
  List<Object?> get props => [];
}

class CategoryChartDashboardBlocEventError
    extends CategoryChartDashboardBlocEvent {
  final String err;
  CategoryChartDashboardBlocEventError({required this.err});
  @override
  List<Object?> get props => [err];
}
