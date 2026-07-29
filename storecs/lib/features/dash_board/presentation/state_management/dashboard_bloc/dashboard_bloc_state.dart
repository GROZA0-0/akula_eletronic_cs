import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

@immutable
abstract class DashboardBlocState extends Equatable {}

class DashboardBlocStateLoading extends DashboardBlocState {
  @override
  List<Object?> get props => [];
}

class DashboardBlocStateLoaded extends DashboardBlocState {
  final EmployeeInfoEntities enitities;
  final DateTime timestamp;
  DashboardBlocStateLoaded({required this.enitities, DateTime?timestamp}):timestamp= timestamp??DateTime.now();

  @override
  List<Object?> get props => [enitities,timestamp];
}

class DashboardBlocStateError extends DashboardBlocState {
  final String err;
  DashboardBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
