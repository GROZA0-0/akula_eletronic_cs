import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

class EmployeeInfoModel {
  final String empId;
  final String empEmail;
  final String empName;
  final String empPhone;
  final String empPic;
  final String empLvl;

  EmployeeInfoModel({
    required this.empId,
    required this.empEmail,
    required this.empName,
    required this.empPhone,
    required this.empPic,
    required this.empLvl,
  });

  Map<String, dynamic> tojson() {
    return {
      "_id": empId,
      "empEmail": empEmail,
      "empName": empName,
      "empPic": empPic,
      "empPhone": empPhone,
      "empLvl": empLvl,
    };
  }

  static EmployeeInfoModel empdataEmpty() {
    return EmployeeInfoModel(
      empId: '',
      empEmail: '',
      empName: '',
      empPhone: '',
      empPic: '',
      empLvl: '',
    );
  }

  factory EmployeeInfoModel.fromEmpSnapShot(Map<String, dynamic> json) {
    return EmployeeInfoModel(
      empId: json['_id'] ?? '',
      empEmail: json['empEmail'] ?? '',
      empName: json['empName'] ?? '',
      empPhone: json['empPhone'] ?? '',
      empPic: json['empPic'] ?? '',
      empLvl: json['empLvl'] ?? '',
    );
  }

  EmployeeInfoEntities toEmployeeInfoEntities() {
    return EmployeeInfoEntities(
      id: empId,
      name: empName,
      phone: empPhone,
      userPic: empPic,
      level: empLvl,
    );
  }
}
