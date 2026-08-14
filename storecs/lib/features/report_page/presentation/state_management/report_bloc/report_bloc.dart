import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';

import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_event.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_state.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';

class ReportBloc extends Bloc<ReportBlocEvent, ReportBlocState> {
  final ReportController controller;
  StreamSubscription? subscription;
  ReportBloc({required this.controller}) : super(ReportBlocStateLoading()) {
    on<ReportBlocEventLoading>((event, emit) async {
      emit(ReportBlocStateLoading());
      /* check if there's emp level */
      if (event.level.trim().isEmpty) {
        emit(ReportBlocStateError(err: "Employee level is not available."));
        return;
      }
      try {
        /* call the for each to get the newest report for the app */
        await emit.forEach<GetReportOfSupervisorEntities>(
          controller.getSuperReport(event.level),
          onData: (entities) => ReportBlocStateLoaded(entities: entities),
        );
      } catch (e) {
        print("error in ReportBloc");
        emit(ReportBlocStateError(err: e.toString()));
      }
    });
  }
}
