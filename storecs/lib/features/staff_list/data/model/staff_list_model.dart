import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';

class StaffListModel {
  final String? id;
  final String email;
  final String name;
  final String phone;
  final String pic;
  final String level;

  StaffListModel({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.pic,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "empEmaile": email,
      "empName": name,
      "empPhone": phone,
      "empPic": pic,
      "empLvl": level,
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
    );
  }

  factory StaffListModel.fromBackEnd(Map<String, dynamic> map) {
    return StaffListModel(
      id: map['_id'],
      email: map['empEmail'],
      name: map['empName'],
      phone: map['empPhone'],
      pic: map['empPic'],
      level: map['empLvl'],
    );
  }
  StaffListEntities toStaffListEntities() {
    return StaffListEntities(
      id: id ?? '',
      name: name,
      phone: phone,
      pic: pic,
      level: level,
    );
  }
}
