import 'package:equatable/equatable.dart';

abstract class PosBlocEvent extends Equatable {}

class PosBlocEventLoading extends PosBlocEvent {
  @override
  List<Object?> get props => [];
}

class PosBlocEventLoaded extends PosBlocEvent {
  final String category;
  PosBlocEventLoaded({required this.category});

  @override
  List<Object?> get props => [category];
}

class PosBlocEventRefresh extends PosBlocEvent {
  final String current;
  PosBlocEventRefresh({required this.current});

  @override
  List<Object?> get props => [current];
}

class PosBlocEventChangeCategory extends PosBlocEvent {
  final String category;
  PosBlocEventChangeCategory({required this.category});

  @override
  List<Object?> get props => [category];
}

class PosBlocEventError extends PosBlocEvent {
  final String err;
  PosBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
