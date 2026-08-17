import 'package:storecs/features/sales_export/domain/enitites/export_reports_entities.dart';

class ExportReportsModel {
  final String category;
  final String searchQuery;
  final DateTime? startDate;
  final DateTime? endDate;

  ExportReportsModel({
    required this.category,
    required this.searchQuery,
    required this.startDate,
    required this.endDate,
  });

  static ExportReportsModel emptyExportReportsModel() {
    return ExportReportsModel(
      category: '',
      searchQuery: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    'category': category,
    if (searchQuery.isNotEmpty) 'search': searchQuery,
    if (startDate != null) 'startDate': startDate!.toIso8601String(),
    if (endDate != null) 'endDate': endDate!.toIso8601String(),
  };

  ExportReportsEntities toExportReportsEntities() {
    return ExportReportsEntities(
      category: category,
      searchQuery: searchQuery,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
