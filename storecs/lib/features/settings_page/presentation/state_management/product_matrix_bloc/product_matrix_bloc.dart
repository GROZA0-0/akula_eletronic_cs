import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_bloc/product_matrix_bloc_event.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_bloc/product_matrix_bloc_state.dart';
import 'package:storecs/features/settings_page/presentation/state_management/product_matrix_controller.dart';

class ProductMatrixBloc
    extends Bloc<ProductMatrixBlocEvent, ProductMatrixBlocState> {
  final ProductMatrixController controller;
  ProductMatrixBloc({required this.controller})
    : super(ProductMatrixBlocStateLoading()) {
    on<ProductMatrixBlocEventLoading>((event, emit) async {
      emit(ProductMatrixBlocStateLoading());
      try {
        await controller.fetchAllItemWithCategories();
        emit(ProductMatrixBlocStateLoaded(entities: controller.entities));
      } catch (e) {
        emit(ProductMatrixBlocStateError(err: e.toString()));
      }
    });
  }
}
