import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_controller.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_event.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_state.dart';

class ProfitLossLogsBloc
    extends Bloc<ProfitLossLogsBlocEvent, ProfitLossLogsBlocState> {
  final ProfitLossController controller;
  ProfitLossLogsBloc(this.controller)
    : super(ProfitLossLogsBlocStateLoading()) {
    on<ProfitLossLogsBlocEventLoading>((event, emit) async {
      emit(ProfitLossLogsBlocStateLoading());
      try {
        final getEntity = await controller.getLogs();
        emit(ProfitLossLogsBlocStateLoaded(entities: getEntity));
      } catch (e) {
        emit(ProfitLossLogsBlocStateError(err: e.toString()));
      }
    });
  }
}
