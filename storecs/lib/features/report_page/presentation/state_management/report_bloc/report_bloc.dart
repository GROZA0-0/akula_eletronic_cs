import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_event.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_state.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';

class ReportBloc extends Bloc<ReportBlocEvent, ReportBlocState> {
  final ReportController controller;
  ReportBloc({required this.controller}) : super(ReportBlocStateLoading()) {
    on<ReportBlocEventLoading>((event, emit) async {
      emit(ReportBlocStateLoading());
      /* check if there's emp level */
      if (event.level.trim().isEmpty) {
        emit(ReportBlocStateError(err: "Employee level is not available."));
        return;
      }
      try {
        final getReport = await controller.getSuperReport(event.level);
        emit(ReportBlocStateLoaded(entities: getReport));
      } catch (e) {
        print("error in ReportBloc");
        emit(ReportBlocStateError(err: e.toString()));
      }
    });
  }
}
