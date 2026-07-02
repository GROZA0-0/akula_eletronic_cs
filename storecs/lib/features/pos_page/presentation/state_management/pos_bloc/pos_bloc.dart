import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_state.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_controller.dart';

class PosBloc extends Bloc<PosBlocEvent, PosBlocState> {
  final PosController controller;
  String currentCategory = 'Phones';
  PosBloc(this.controller, this.currentCategory)
    : super(PosBlocStateLoading()) {
    on<PosBlocEventLoading>((event, emit) async {
      /* emit(PosBlocStateLoading()); */
      add(PosBlocEventLoaded(category: currentCategory));
    });
    on<PosBlocEventLoaded>(onFetchByCategory);
    on<PosBlocEventChangeCategory>(onChangeCategory);
  }
  Future<void> onFetchByCategory(
    PosBlocEventLoaded event,
    Emitter<PosBlocState> emit,
  ) async {
    try {
      emit(PosBlocStateLoading());
      currentCategory = event.category;
      final product = await controller.getCategoriesWithItems(event.category);
      if (product.isEmpty) {
        emit(PosBlocStateEmpty());
      } else {
        emit(PosBlocStateLoaded(entities: product, category: event.category));
      }
    } catch (e) {
      print('BLoC  onFetchByCategory error: $e');
      emit(PosBlocStateError(err: e.toString()));
    }
  }

  Future<void> onChangeCategory(
    PosBlocEventChangeCategory change,
    Emitter<PosBlocState> emit,
  ) async {
    try {
      if (currentCategory == change.category) return;
      // emit(PosBlocStateLoading());
      add(PosBlocEventLoaded(category: change.category));
    } catch (e) {
      print('BLoC onChangeCategory error: $e');
      emit(PosBlocStateError(err: e.toString()));
    }
  }

  Future<void> onRefreh(
    PosBlocStateLoading event,
    Emitter<PosBlocState> emit,
  ) async {
    add(PosBlocEventRefresh(current: currentCategory));
  }
}
