import 'package:equatable/equatable.dart';

abstract class ProductMatrixBlocEvent extends Equatable {}

class ProductMatrixBlocEventLoading extends ProductMatrixBlocEvent {
  @override
  List<Object?> get props => [];
}

class ProductMatrixBlocEventError extends ProductMatrixBlocEvent {
  final String err;
  ProductMatrixBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
