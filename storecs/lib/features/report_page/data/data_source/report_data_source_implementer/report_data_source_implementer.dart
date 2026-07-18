import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/report_page/data/data_source/report_data_source_repository/report_data_source_repository.dart';
import 'package:storecs/features/report_page/data/model/report_model.dart';

class ReportDataSourceImplementer implements ReportDataSourceRepository {
  final Dio dio;
  ReportDataSourceImplementer({required this.dio});

  @override
  Future<ReportModel> tomakeReportDataSourceRepo(
    String reportTitle,
    String reportSubTitle,
  ) async {
    final storeReport = '${Env.baseURL}storeReportRoute';
    final Map<String, dynamic> data = {
      "reportTitle": reportTitle,
      "reportSubTitle": reportSubTitle,
    };
    final res = await dio.post(
      storeReport,
      data: data,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return ReportModel.emptyReport();
      } else {
        final info = res.data;
        return ReportModel.fromJson(info);
      }
    } else {
      throw Exception("Any issue with creating account ? : ${res.statusCode}");
    }
  }
}
