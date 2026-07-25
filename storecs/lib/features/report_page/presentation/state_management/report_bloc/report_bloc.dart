import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/Core/config/permissions.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_event.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_state.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';

class ReportBloc extends Bloc<ReportBlocEvent, ReportBlocState> {
  final ReportController controller;
  ReportBloc({required this.controller}) : super(ReportBlocStateLoading()) {
    on<ReportBlocEventLoading>((event, emit) async {
      emit(ReportBlocStateLoading());
      try {
        final idPermission = Permissions(
          state: controller.perEntities,
        ).reportPer;
        final getReport = await controller.getSuperReport(idPermission);
        emit(ReportBlocStateLoaded(entities: getReport));
      } catch (e) {
        print("error in ReportBloc");
        emit(ReportBlocStateError(err: e.toString()));
      }
    });
  }
}
