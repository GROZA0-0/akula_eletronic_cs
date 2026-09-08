import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_state.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_controller.dart';

class PosBloc extends Bloc<PosBlocEvent, PosBlocState> {
  final PosController controller;
  String currentCategory = 'Phones';
  PosBloc(this.controller, this.currentCategory)
    : super(PosBlocStateLoading()) {
    on<PosBlocEventLoading>((event, emit) async {
      add(PosBlocEventLoaded(category: currentCategory));
    });
    on<PosBlocEventLoaded>(onFetchByCategory);
    on<PosBlocEventChangeCategory>(onChangeCategory);
  }
  Future<void> onFetchByCategory(
    PosBlocEventLoaded event,
    Emitter<PosBlocState> emit,
  ) async {
    emit(PosBlocStateLoading());
    try {
      currentCategory = event.category;
      await emit.forEach<List<PosEntities>>(
        controller.getCategoriesWithItems(event.category),
        onData: (entities) {
          if (entities.isEmpty) {
            return PosBlocStateEmpty();
          } else {
            return PosBlocStateLoaded(
              entities: entities,
              category: event.category,
            );
          }
        },
        onError: (error, stackTrace) =>
            PosBlocStateError(err: error.toString()),
      );
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
