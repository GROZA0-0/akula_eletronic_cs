import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';

abstract class ExportReportsRepo {
  Future<String> downloadExportFileRepo(ExportReportsModel params);
  Future<dynamic> fetchPreviewDataSource(ExportReportsModel params);
}
