import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_event.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_state.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  final FetchEmployeeInfoDashBoardController boardController;
  final String id;
  DashboardBloc(this.boardController, this.id)
    : super(DashboardBlocStateLoading()) {
    on<DashboardBlocEventLoading>((event, emit) async {
      emit(DashboardBlocStateLoading());
      try {
        final getEmpInfo = await boardController.getEmployeeInfo(id);
        emit(DashboardBlocStateLoaded(enitities: getEmpInfo));
      } catch (e) {
        print("any errors into dashboard bloc ${e.toString()}");
        emit((DashboardBlocStateError(err: e.toString())));
      }
    });
  }
}
