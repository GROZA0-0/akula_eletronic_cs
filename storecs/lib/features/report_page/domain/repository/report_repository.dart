import 'package:storecs/features/report_page/domain/entities/report_entities.dart';

abstract class ReportRepository {
  Future<ReportEntities> reportRepository(
    String reportTitle,
    String reportSubTitle,
  );
}
