import 'package:equatable/equatable.dart';

abstract class StaffListBlocEvent extends Equatable {}

class StaffListBlocEventLoading extends StaffListBlocEvent {
  @override
  List<Object?> get props => [];
}

class StaffListBlocEventError extends StaffListBlocEvent {
  final String err;
  StaffListBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
