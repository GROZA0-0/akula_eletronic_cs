import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';

class StaffListModel {
  final String? id;
  final String email;
  final String name;
  final String phone;
  final String pic;
  final String level;
  final UserAccountStatus empStatus;

  StaffListModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.pic,
    required this.level,
    this.empStatus = UserAccountStatus.offline,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "empEmaile": email,
      "empName": name,
      "empPhone": phone,
      "empPic": pic,
      "empLvl": level,
      "empStatus": empStatus,
    };
  }

  static StaffListModel empEmptyInfo() {
    return StaffListModel(
      id: '',
      email: '',
      name: '',
      phone: '',
      pic: '',
      level: '',
      empStatus: UserAccountStatus.offline,
    );
  }

  factory StaffListModel.fromBackEnd(Map<String, dynamic> map) {
    final statusString = map['empStatus']?.toString().toLowerCase();
    return StaffListModel(
      id: map['_id'],
      email: map['empEmail'],
      name: map['empName'],
      phone: map['empPhone'],
      pic: map['empPic'],
      level: map['empLvl'],
      empStatus: UserAccountStatus.values.firstWhere(
        (element) => element.name.toLowerCase() == statusString,
        orElse: () => UserAccountStatus.offline,
      ),
    );
  }
  StaffListEntities toStaffListEntities() {
    return StaffListEntities(
      id: id ?? '',
      name: name,
      phone: phone,
      pic: pic,
      level: level,
      empStatus: empStatus,
    );
  }
}
