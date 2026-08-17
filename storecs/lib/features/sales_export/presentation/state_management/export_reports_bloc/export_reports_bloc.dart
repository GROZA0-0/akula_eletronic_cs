import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/sales_export/domain/repository/export_reports_repo.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc_event.dart';
import 'package:storecs/features/sales_export/presentation/state_management/export_reports_bloc/export_reports_bloc_state.dart';

class ExportReportsBloc
    extends Bloc<ExportReportsBlocEvent, ExportReportsBlocState> {
  final ExportReportsRepo controller;
  ExportReportsBloc(this.controller) : super(ExportReportsBlocStateInitial()) {
    on<PreviewExportEvent>((event, emit) async {
      emit(ExportReportsBlocStateLoading());
      try {
        final filePath = await controller.fetchPreviewDataSource(
          event.reportsModel,
        );
        emit(ExportReportsBlocStatePreviewed(items: filePath));
      } catch (e) {
        emit(ExportReportsBlocStateError(err: e.toString()));
      }
    });
    on<TriggerExportEvent>((event, emit) async {
      emit(ExportReportsBlocStateLoading());
      try {
        final filePath = await controller.downloadExportFileRepo(
          event.reportsModel,
        );
        emit(ExportReportsBlocStateLoaded(filePath: filePath));
      } catch (e) {
        emit(ExportReportsBlocStateError(err: e.toString()));
      }
    });
  }
}
