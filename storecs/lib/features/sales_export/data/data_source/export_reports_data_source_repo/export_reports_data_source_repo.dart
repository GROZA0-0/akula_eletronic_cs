import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';

abstract class ExportReportsDataSourceRepo {
  Future<dynamic> fetchPreviewDataSource(ExportReportsModel params);
  Future<List<int>> downloadExportFile(ExportReportsModel params);
}
