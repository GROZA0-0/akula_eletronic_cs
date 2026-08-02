import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:storecs/features/dash_board/domain/entities/category_dashboard_entities.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/dash_board/domain/entities/review_entities.dart';

@immutable
abstract class DashboardBlocState extends Equatable {}

class DashboardBlocStateLoading extends DashboardBlocState {
  @override
  List<Object?> get props => [];
}

class DashboardBlocStateLoaded extends DashboardBlocState {
  final EmployeeInfoEntities enitities;

  final DateTime timestamp;
  DashboardBlocStateLoaded({required this.enitities, DateTime? timestamp})
    : timestamp = timestamp ?? DateTime.now();

  @override
  List<Object?> get props => [enitities, timestamp];
}

class DashboardBlocStateError extends DashboardBlocState {
  final String err;
  DashboardBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

abstract class ReviewDashboardBlocState extends Equatable {}

class ReviewDashboardBlocStateLoading extends ReviewDashboardBlocState {
  @override
  List<Object?> get props => [];
}

class ReviewDashboardBlocStateLoaded extends ReviewDashboardBlocState {
  final List<ReviewEntities> entities;
  ReviewDashboardBlocStateLoaded({required this.entities});
  @override
  List<Object?> get props => [entities];
}

class ReviewDashboardBlocStateError extends ReviewDashboardBlocState {
  final String err;
  ReviewDashboardBlocStateError({required this.err});
  @override
  List<Object?> get props => [err];
}
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////

abstract class CategoryChartDashboardBlocState extends Equatable {}

class CategoryChartDashboardBlocStateLoading
    extends CategoryChartDashboardBlocState {
  @override
  List<Object?> get props => [];
}

class CategoryChartDashboardBlocStateLoaded
    extends CategoryChartDashboardBlocState {
  final List<CategoryDashboardEntities> entities;
  CategoryChartDashboardBlocStateLoaded({required this.entities});
  @override
  List<Object?> get props => [entities];
}

class CategoryChartDashboardBlocStateError
    extends CategoryChartDashboardBlocState {
  final String err;
  CategoryChartDashboardBlocStateError({required this.err});
  @override
  List<Object?> get props => [err];
}
