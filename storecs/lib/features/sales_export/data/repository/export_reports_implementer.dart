import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:storecs/features/sales_export/data/data_source/export_reports_data_source_repo/export_reports_data_source_repo.dart';
import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';
import 'package:storecs/features/sales_export/domain/repository/export_reports_repo.dart';

class ExportReportsImplementer implements ExportReportsRepo {
  final ExportReportsDataSourceRepo reportsDataSourceRepo;
  ExportReportsImplementer({required this.reportsDataSourceRepo});

  @override
  Future<String> downloadExportFileRepo(ExportReportsModel params) async {
    Directory? downloadsDir;
    try {
      if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
        downloadsDir = await getDownloadsDirectory();
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      if (downloadsDir == null) {
        throw Exception('Could not access Downloads folder.');
      }
      final model = await reportsDataSourceRepo.downloadExportFile(params);
      final fileName = 'export_${DateTime.now().millisecondsSinceEpoch}.xlsx';
      final filePath = '${downloadsDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(model);
      return filePath;
    } catch (e) {
      print(
        "any errors in ExportReportsImplementer downloadExportFileRepo method $e",
      );
      throw e.toString();
    }
  }

  @override
  Future<dynamic> fetchPreviewDataSource(ExportReportsModel params) async {
    try {
      final model = await reportsDataSourceRepo.fetchPreviewDataSource(params);

      return model;
    } catch (e) {
      print(
        "any errors in ExportReportsImplementer fetchPreviewDataSource method $e",
      );
      throw e.toString();
    }
  }
}
