import 'package:storecs/features/report_page/data/model/report_model.dart';

abstract class ReportDataSourceRepository {
  Future<ReportModel> tomakeReportDataSourceRepo(
    String id,
    String email,
    String level,
    String reportTitle,
    String reportSubTitle,
  );

  Future<ReportModel> toGetSupervisorReportDataSourceRepo(String id);
}
