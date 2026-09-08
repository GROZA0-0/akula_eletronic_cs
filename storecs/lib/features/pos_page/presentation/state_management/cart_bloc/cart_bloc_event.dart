import 'package:equatable/equatable.dart';

abstract class CartBlocEvent extends Equatable {}

class CartBlocEventLoading extends CartBlocEvent {
  @override
  List<Object?> get props => [];
}

class CartBlocEventError extends CartBlocEvent {
  final String err;
  CartBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
