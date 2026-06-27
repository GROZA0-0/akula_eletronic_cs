import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_bloc/pos_bloc_state.dart';
import 'package:storecs/features/pos_page/presentation/state_management/pos_controller.dart';

class PosBloc extends Bloc<PosBlocEvent, PosBlocState> {
  final PosController controller;
  PosBloc(this.controller) : super(PosBlocStateLoading()) {
    on<PosBlocEventLoading>((event, emit) async {
      emit(PosBlocStateLoading());
      try {
        final getProducts = await controller.getAllProducts();
        emit(PosBlocStateLoaded(entities: getProducts));
      } catch (e) {
        emit(PosBlocStateError(err: e.toString()));
      }
    });
  }
}
