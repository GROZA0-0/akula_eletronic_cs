import 'package:equatable/equatable.dart';

class StaffListEntities extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String pic;
  final String level;
  const StaffListEntities({
    required this.id,
    required this.name,
    required this.phone,
    required this.pic,
    required this.level,
  });

  @override
  List<Object?> get props => [id, name, phone, pic, level];
}
