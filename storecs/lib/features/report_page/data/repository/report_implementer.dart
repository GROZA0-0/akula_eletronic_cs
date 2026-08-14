import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:storecs/features/report_page/data/data_source/report_data_source_repository/report_data_source_repository.dart';
import 'package:storecs/features/report_page/data/model/report_model.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';
import 'package:storecs/features/report_page/domain/entities/report_entities.dart';
import 'package:storecs/features/report_page/domain/repository/report_repository.dart';

class ReportImplementer implements ReportRepository {
  final ReportDataSourceRepository reportDataSourceRepository;
  ReportImplementer({required this.reportDataSourceRepository});
  final reportsStreamController =
      /* hold the latest value of the report */
      BehaviorSubject<GetReportOfSupervisorEntities>();
  @override
  Future<ReportEntities> reportRepository(
    String id,
    String email,
    String level,
    String reportTitle,
    String reportSubTitle,
  ) async {
    try {
      final model = await reportDataSourceRepository.tomakeReportDataSourceRepo(
        id,
        email,
        level,
        reportTitle,
        reportSubTitle,
      );
      return model.toReportEntities();
    } catch (e) {
      print("any errors in ReportImplementer  $e");
      throw e.toString();
    }
  }

  @override
  Future<GetReportOfSupervisorEntities> getReportRepository(
    String level,
  ) async {
    try {
      /* fetch the report model */
      final ReportModel model = await reportDataSourceRepository
          .toGetSupervisorReportDataSourceRepo(level);
      /* get the entity */
      final enitiy = model.toGetReportOfSupervisorEntities();
      /* pass the model to the stream */
      reportsStreamController.add(enitiy);
      /* return the value */
      return enitiy;
    } catch (e) {
      print("any errors in ReportImplementer  $e");
      throw e.toString();
    }
  }

  @override
  Stream<GetReportOfSupervisorEntities> get reportStream =>
      reportsStreamController.stream; /* init the stream */
}
