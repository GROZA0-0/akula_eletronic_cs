import 'package:equatable/equatable.dart';

class GetReportOfSupervisorEntities extends Equatable {
  final String empId;
  final String level;
  final String title;
  final String subTitle;
  const GetReportOfSupervisorEntities({
    required this.empId,
    required this.level,
    required this.title,
    required this.subTitle,
  });

  static GetReportOfSupervisorEntities emptyReport() {
    return GetReportOfSupervisorEntities(
      empId: '',
      title: '',
      subTitle: '',
      level: '',
    );
  }

  factory GetReportOfSupervisorEntities.fromJson(Map<String, dynamic> json) {
    return GetReportOfSupervisorEntities(
      empId: json['empId'] ?? '',

      level: json['empLvl'] ?? '',
      title: json['reportTitle'] ?? '',
      subTitle: json['reportSubTitle'] ?? '',
    );
  }

  Map<String, dynamic> toCachedJson() {
    return {
      "empId": empId,
      "empLvl": level,
      "reportTitle": title,
      "reportSubTitle": subTitle,
    };
  }

  @override
  List<Object?> get props => [empId, level, title, subTitle];
}
