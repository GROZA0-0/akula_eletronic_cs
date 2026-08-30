import 'package:equatable/equatable.dart';
import 'package:storecs/features/settings_page/domain/entities/product_matrix_entities.dart';

abstract class ProductMatrixBlocState extends Equatable {}

class ProductMatrixBlocStateLoading extends ProductMatrixBlocState {
  @override
  List<Object?> get props => [];
}

class ProductMatrixBlocStateLoaded extends ProductMatrixBlocState {
  final List<ProductMatrixEntities> entities;
  ProductMatrixBlocStateLoaded({required this.entities});

  @override
  List<Object?> get props => [entities];
}

class ProductMatrixBlocStateError extends ProductMatrixBlocState {
  final String err;
  ProductMatrixBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
