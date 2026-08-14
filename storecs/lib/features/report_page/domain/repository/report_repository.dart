import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';
import 'package:storecs/features/report_page/domain/entities/report_entities.dart';

abstract class ReportRepository {
  Stream<GetReportOfSupervisorEntities>
  get reportStream; /* get the stream from the entity */
  Future<ReportEntities> reportRepository(
    String id,
    String email,
    String level,
    String reportTitle,
    String reportSubTitle,
  );
  Future<GetReportOfSupervisorEntities> getReportRepository(String level);
}
