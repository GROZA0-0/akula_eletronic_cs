import 'package:equatable/equatable.dart';
import 'package:storecs/features/product_list/domain/entities/product_list_entities.dart';

abstract class ProductListStateBloc extends Equatable {}

class ProductListStateBlocLoading extends ProductListStateBloc {
  @override
  List<Object?> get props => [];
}

class ProductListStateBlocError extends ProductListStateBloc {
  final String err;
  ProductListStateBlocError({required this.err});

  @override
  List<Object?> get props => [err];
}

class ProductListStateBlocLoaded extends ProductListStateBloc {
  final List<GetProductWithCategoryListEntities> entities;
  final String category;
  ProductListStateBlocLoaded({required this.entities, required this.category});

  @override
  List<Object?> get props => [entities, category];
}

class ProductListStateBlocLoadedEmpty extends ProductListStateBloc {
  @override
  List<Object?> get props => [];
}
