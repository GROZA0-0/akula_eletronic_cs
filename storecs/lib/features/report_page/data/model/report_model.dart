import 'package:storecs/features/report_page/domain/entities/report_entities.dart';

class ReportModel {
  String? id;
  final String reportTitle;
  final String reportSubTitle;
  DateTime? createdAt;

  ReportModel({
    this.id,
    required this.reportTitle,
    required this.reportSubTitle,
    this.createdAt,
  });

  static ReportModel emptyReport() {
    return ReportModel(
      id: '',
      reportTitle: '',
      reportSubTitle: '',
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'reportTitle': reportTitle,
      'reportSubTitle': reportSubTitle,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'] ?? '',
      reportTitle: json['reportTitle'] ?? '',
      reportSubTitle: json['reportSubTitle'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  ReportEntities toReportEntities() {
    return ReportEntities(
      id: id ?? '',
      reportTitle: reportTitle,
      reportSubTitle: reportSubTitle,
    );
  }
}
