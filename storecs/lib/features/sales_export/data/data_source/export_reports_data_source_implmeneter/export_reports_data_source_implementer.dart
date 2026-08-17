import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/sales_export/data/data_source/export_reports_data_source_repo/export_reports_data_source_repo.dart';
import 'package:storecs/features/sales_export/data/model/export_reports_model.dart';

class ExportReportsDataSourceImplementer
    implements ExportReportsDataSourceRepo {
  final Dio dio;
  ExportReportsDataSourceImplementer({required this.dio});

  @override
  Future<List<int>> downloadExportFile(ExportReportsModel params) async {
    final exportData = '${Env.baseURL}downloadData';
    final res = await dio.get(
      exportData,
      queryParameters: params.toJson(),
      options: Options(
        responseType: ResponseType.bytes,
        validateStatus: (status) => status! < 600,
      ),
    );

    if (res.statusCode == 200) {
      return res.data;
    } else {
      throw Exception(
        'Server returned of download export data  status code: ${res.statusCode}',
      );
    }
  }

  @override
  Future<dynamic> fetchPreviewDataSource(ExportReportsModel params) async {
    final fetchExportData = '${Env.baseURL}fetchExportDataRoute';
    final res = await dio.get(
      fetchExportData,
      queryParameters: params.toJson(),
    );
    if (res.statusCode == 200) {
      dynamic data = res.data;
      if (data == null) {
        return [];
      }
      if (data is String) {
        final trimmed = data.trim();
        if (trimmed.isEmpty) {
          return [];
        }
        data = jsonDecode(trimmed);
      }
      if (data is List) {
        if (data.isEmpty) return [];
        return data
            .map((info) => Map<String, dynamic>.from(info as Map))
            .toList();
      }
      throw Exception('Unexpected data format received from server.');
    } else {
      throw Exception(
        'Server returned of fetching data status code: ${res.statusCode}',
      );
    }
  }
}
