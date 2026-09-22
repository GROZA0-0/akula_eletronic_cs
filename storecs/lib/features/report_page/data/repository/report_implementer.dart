import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storecs/features/report_page/data/data_source/report_data_source_repository/report_data_source_repository.dart';
import 'package:storecs/features/report_page/data/model/report_model.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';
import 'package:storecs/features/report_page/domain/entities/report_entities.dart';
import 'package:storecs/features/report_page/domain/repository/report_repository.dart';

class ReportImplementer implements ReportRepository {
  final ReportDataSourceRepository reportDataSourceRepository;
  ReportImplementer({required this.reportDataSourceRepository});
  final reportsStreamController =
      /* hold the latest value of the report */
      BehaviorSubject<GetReportOfSupervisorEntities>();

  static const reportCached = 'report_cached';
  @override
  Future<ReportEntities> reportRepository(
    String id,
    String email,
    String level,
    String reportTitle,
    String reportSubTitle,
  ) async {
    try {
      final model = await reportDataSourceRepository.tomakeReportDataSourceRepo(
        id,
        email,
        level,
        reportTitle,
        reportSubTitle,
      );
      return model.toReportEntities();
    } catch (e) {
      print("any errors in ReportImplementer  $e");
      throw e.toString();
    }
  }

  @override
  Future<GetReportOfSupervisorEntities> getReportRepository(
    String level,
  ) async {
    try {
      /* fetch the report model */
      final ReportModel model = await reportDataSourceRepository
          .toGetSupervisorReportDataSourceRepo(level);
      /* get the entity */
      final enitiy = model.toGetReportOfSupervisorEntities();
      /* pass the model to the stream */
      reportsStreamController.add(enitiy);
      savedToCachedData(enitiy);
      /* return the value */
      return enitiy;
    } catch (e) {
      // print("any errors in ReportImplementer  $e");
      return reportsStreamController.valueOrNull ??
          GetReportOfSupervisorEntities.emptyReport();
    }
  }

  @override
  Stream<GetReportOfSupervisorEntities> get reportStream =>
      reportsStreamController.stream;

  @override
  Future<void> reportInfoLoadCachedData() async {
    final prefs = await SharedPreferences.getInstance();
    final cached = prefs.getString(reportCached);
    if (cached != null) {
      final lastReportData = jsonDecode(cached);
      final entities = GetReportOfSupervisorEntities.fromJson(lastReportData);
      reportsStreamController.add(entities);
    }
  }

  @override
  Future<void> savedToCachedData(GetReportOfSupervisorEntities entities) async {
    final prefs = await SharedPreferences.getInstance();
    final dataMap = entities.toCachedJson();
    final decoded = jsonEncode(dataMap);
    entities.toCachedJson();
    await prefs.setString(reportCached, decoded);
  }
}
