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

  @override
  List<Object?> get props => [empId, level, title, subTitle];
}
