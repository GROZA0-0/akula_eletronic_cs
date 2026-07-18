import 'package:storecs/features/report_page/data/model/report_model.dart';

abstract class ReportDataSourceRepository {
  Future<ReportModel> tomakeReportDataSourceRepo(
    String reportTitle,
    String reportSubTitle,
  );
}
