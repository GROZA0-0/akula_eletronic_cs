import 'package:equatable/equatable.dart';

abstract class PosBlocEvent extends Equatable {}

class PosBlocEventLoading extends PosBlocEvent {
  @override
  List<Object?> get props => [];
}

class PosBlocEventError extends PosBlocEvent {
  final String err;
  PosBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
