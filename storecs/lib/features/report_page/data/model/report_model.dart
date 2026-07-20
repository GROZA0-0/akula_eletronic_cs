import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';
import 'package:storecs/features/report_page/domain/entities/report_entities.dart';

class ReportModel {
  String? id;
  String? empId;
  String? email;
  String? level;
  final String reportTitle;
  final String reportSubTitle;
  DateTime? createdAt;

  ReportModel({
    this.id,
    this.empId,
    this.email,
    this.level,
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
      'empId': empId,
      'empEmail': email,
      'empLvl': level,
      'reportTitle': reportTitle,
      'reportSubTitle': reportSubTitle,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['_id'] ?? '',
      empId: json['empId'] ?? '',
      email: json['empEmail'] ?? '',
      level: json['empLvl'] ?? '',
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
      empId: empId ?? '',
      email: email ?? '',
      level: level ?? '',
      reportTitle: reportTitle,
      reportSubTitle: reportSubTitle,
    );
  }

  GetReportOfSupervisorEntities toGetReportOfSupervisorEntities() {
    return GetReportOfSupervisorEntities(
      empId: empId ?? '',
      level: level ?? '',
      title: reportTitle,
      subTitle: reportSubTitle,
    );
  }
}
