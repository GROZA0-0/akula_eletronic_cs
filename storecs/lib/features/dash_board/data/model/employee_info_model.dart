import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';

class EmployeeInfoModel {
  final String empId;
  final String empEmail;
  final String empName;
  final String empPhone;
  final String empPic;
  final String empLvl;
  final UserAccountStatus empStatus;

  EmployeeInfoModel({
    required this.empId,
    required this.empEmail,
    required this.empName,
    required this.empPhone,
    required this.empPic,
    required this.empLvl,
    this.empStatus = UserAccountStatus.offline,
  });

  Map<String, dynamic> tojson() {
    return {
      "_id": empId,
      "empEmail": empEmail,
      "empName": empName,
      "empPic": empPic,
      "empPhone": empPhone,
      "empLvl": empLvl,
      "empStatus": empStatus,
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
      empStatus: UserAccountStatus.offline,
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
      empStatus: UserAccountStatus.values.firstWhere(
        (element) => element.name == json['empStatus'],
        orElse: () => UserAccountStatus.offline,
      ),
    );
  }

  EmployeeInfoEntities toEmployeeInfoEntities() {
    return EmployeeInfoEntities(
      id: empId,
      email: empEmail,
      name: empName,
      phone: empPhone,
      userPic: empPic,
      level: empLvl,
      status: empStatus,
    );
  }
}
