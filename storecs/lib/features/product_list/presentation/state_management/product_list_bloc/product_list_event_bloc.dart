import 'package:equatable/equatable.dart';

abstract class ProductListEventBloc extends Equatable {}

class ProductListEventBlocLoading extends ProductListEventBloc {
  @override
  List<Object?> get props => [];
}

class ProductListEventBlocLoaded extends ProductListEventBloc {
  final String category;
  ProductListEventBlocLoaded({required this.category});

  @override
  List<Object?> get props => [category];
}

class ProductListEventBlocRefresh extends ProductListEventBloc {
  final String current;
  ProductListEventBlocRefresh(this.current);
  @override
  List<Object?> get props => [current];
}

class ProductListEventBlocChangeCategoryEvent extends ProductListEventBloc {
  final String category;
  ProductListEventBlocChangeCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class ProductListEventBlocError extends ProductListEventBloc {
  final String err;
  ProductListEventBlocError({required this.err});

  @override
  List<Object?> get props => [err];
}
