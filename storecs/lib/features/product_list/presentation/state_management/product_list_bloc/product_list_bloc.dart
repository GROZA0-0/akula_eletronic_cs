import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storecs/features/product_list/presentation/state_management/product_list_bloc/product_list_event_bloc.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_bloc/product_list_state_bloc.dart';
import 'package:storecs/features/product_list/presentation/state_management/product_list_controller.dart';

class ProductListBloc extends Bloc<ProductListEventBloc, ProductListStateBloc> {
  final ProductListController repo;
  String currentCategory = 'Phones';
  ProductListBloc({required this.repo}) : super(ProductListStateBlocLoading()) {
    on<ProductListEventBlocLoading>((event, emit) async {
      add(ProductListEventBlocLoaded(category: currentCategory));
    });
    on<ProductListEventBlocLoaded>(onFetchByCategory);
    on<ProductListEventBlocChangeCategoryEvent>(onChangeCategory);
  }
  Future<void> onFetchByCategory(
    ProductListEventBlocLoaded event,
    Emitter<ProductListStateBloc> emit,
  ) async {
    try {
      currentCategory = event.category;

      // print('Fetching: ${event.category}');

      final products = await repo.getCategories(event.category);

      if (products.isEmpty) {
        emit(ProductListStateBlocLoadedEmpty());
      } else {
        emit(
          ProductListStateBlocLoaded(
            entities: products,
            category: event.category,
          ),
        );
      }
    } catch (e) {
      print('BLoC error: $e');
      emit(ProductListStateBlocError(err: e.toString()));
    }
  }

  Future<void> onChangeCategory(
    ProductListEventBlocChangeCategoryEvent category,
    Emitter<ProductListStateBloc> emit,
  ) async {
    if (currentCategory == category.category) return;
    add(ProductListEventBlocChangeCategoryEvent(category: category.category));
  }

  Future<void> onRefresh(
    ProductListEventBlocLoading event,
    Emitter<ProductListStateBloc> emit,
  ) async {
    add(ProductListEventBlocRefresh(currentCategory));
  }
}
