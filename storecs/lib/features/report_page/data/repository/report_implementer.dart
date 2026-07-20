import 'package:storecs/features/report_page/data/data_source/report_data_source_repository/report_data_source_repository.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';
import 'package:storecs/features/report_page/domain/entities/report_entities.dart';
import 'package:storecs/features/report_page/domain/repository/report_repository.dart';

class ReportImplementer implements ReportRepository {
  final ReportDataSourceRepository reportDataSourceRepository;
  const ReportImplementer({required this.reportDataSourceRepository});
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
  Future<GetReportOfSupervisorEntities> getReportRepository(String id) async {
    try {
      final model = await reportDataSourceRepository
          .toGetSupervisorReportDataSourceRepo(id);
      return model.toGetReportOfSupervisorEntities();
    } catch (e) {
      print("any errors in ReportImplementer  $e");
      throw e.toString();
    }
  }
}
