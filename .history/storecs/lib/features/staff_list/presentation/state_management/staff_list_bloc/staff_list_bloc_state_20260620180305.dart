import 'package:equatable/equatable.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';

abstract class StaffListBlocState extends Equatable {}

class StaffListBlocStateLoading extends StaffListBlocState {
  @override
  List<Object?> get props => [];
}

class StaffListBlocStateLoaded extends StaffListBlocState {
  final StaffListEntities entities;
  StaffListBlocStateLoaded({required this.entities});
  @override
  List<Object?> get props => [entities];
}

class StaffListBlocStateError extends StaffListBlocState {
  final String err;
  StaffListBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
