import 'package:storecs/Core/config/env.dart';
import 'package:dio/dio.dart';
import 'package:storecs/features/auth/data/data_source/data_source_repo/auth_data_source_repo.dart';
import 'package:storecs/features/auth/data/models/employee_model.dart';

class EmployeeInfoDataSourceImplemter implements EmpDataSoruce {
  final Dio client;
  EmployeeInfoDataSourceImplemter({required this.client});

  @override
  Future<EmployeeModel> toCreateAccAuthDataSoruce(
    String id,
    String idToken,
    String email,
    String password,
    String name,
    String phone,
    String picture,
    String level,
  ) async {
    final createAcc = '${Env.baseURL}createEmployeeAccount';
    final Map<String, dynamic> body = {
      '_id': id,
      'idToken': idToken,
      'empEmail': email,
      'empPassword': password,
      'empName': name,
      'empPhone': phone,
      'empLvl': level,
      'empPic': picture,
    };
    final res = await client.post(
      createAcc,
      data: body,
      options: Options(
        contentType: 'application/json',
        validateStatus: (status) => status! < 600,
      ),
    );
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return EmployeeModel.empdataEmpty();
      } else {
        final empData = res.data;
        /*  print('Status: ${res.statusCode}');
        print('Response: ${res.data}'); */
        return EmployeeModel.fromEmpSnapShot(empData);
      }
    } else {
      throw Exception("Any issue with creating account ? : ${res.statusCode}");
    }
  }
}
