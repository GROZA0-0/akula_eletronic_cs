import 'package:storecs/features/auth/domain/entities/employee_entities.dart';

class EmployeeModel {
  final String? id;
  final String? idToken;
  final String? empEmail;
  final String? empPassword;
  final String? empName;
  final String? empPic;
  final String? empPhone;
  final String? empLvl;

  const EmployeeModel({
    required this.id,
    required this.idToken,
    required this.empEmail,
    required this.empPassword,
    required this.empName,
    required this.empPhone,
    required this.empPic,
    required this.empLvl,
  });

  Map<String, dynamic> tojson() {
    return {
      "_id": id,
      "idToken": idToken,
      "empEmail": empEmail,
      "empPassword": empPassword,
      "empName": empName,
      "empPic": empPic,
      "empPhone": empPhone,
      "empLvl": empLvl,
    };
  }

  static EmployeeModel empdataEmpty() {
    return EmployeeModel(
      id: '',
      idToken: '',
      empEmail: '',
      empPassword: '',
      empName: '',
      empPhone: '',
      empPic: '',
      empLvl: '',
    );
  }

  factory EmployeeModel.fromEmpSnapShot(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['_id'] ?? '',
      idToken: json['idToken'] ?? '',
      empEmail: json['empEmail'] ?? '',
      empPassword: json['empPassword'] ?? '',
      empName: json['empName'] ?? '',
      empPhone: json['empPhone'] ?? '',
      empPic: json['empPic'] ?? '',
      empLvl: json['empLvl'] ?? '',
    );
  }

  EmployeesCreatingAccountEntities toEmployeeCreatingAccountEntities() {
    return EmployeesCreatingAccountEntities(
      id: id ?? '',
      idToken: id ?? '',
      empEmail: empEmail ?? '',
      empPassword: empPassword ?? '',
      empName: empName ?? '',
      empPhone: empPhone ?? '',
      empPic: empPic ?? '',
      empLvl: empLvl ?? '',
    );
  }
}
