import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/dash_board/data/data_source/data_source_repo/attendance_data_source_repository.dart';
import 'package:storecs/features/dash_board/data/model/attendance_model.dart';

class AttendanceDataSourceImplementer
    implements AttendanceDataSourceRepository {
  final Dio dio;
  AttendanceDataSourceImplementer({required this.dio});

  @override
  Future<AttendanceModel> storeAttDataSourceRepo(
    String empEmail,
    UserAccountStatus status,
  ) async {
    final storeAtt = '${Env.baseURL}makeEmployeeAttendanceRoute/$empEmail';

    final res = await dio.post(
      storeAtt,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
      data: jsonEncode({'attendance': status.name}),
    );

    if (res.statusCode == 200) {
      if (res.data == null) {
        return AttendanceModel.emptyAttendanceModel();
      } else {
        final data = res.data['data'];
        return AttendanceModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with storing attendance ? : ${res.statusCode}",
      );
    }
  }
}
