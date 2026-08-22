import 'package:equatable/equatable.dart';
import 'package:storecs/Core/config/account_status.dart';

abstract class DashboardBlocEvent extends Equatable {}

class DashboardBlocEventLoading extends DashboardBlocEvent {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class DashboardBlocEventChangeStatus extends DashboardBlocEvent {
  final String id;
  String empEmail;
  final UserAccountStatus status;
  DashboardBlocEventChangeStatus({
    required this.id,
    required this.status,
    required this.empEmail,
  });

  @override
  List<Object?> get props => [id, status];
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
