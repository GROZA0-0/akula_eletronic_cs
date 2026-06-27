import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';

abstract class StaffListRepo {
  Future<StaffListEntities> toStaffListdomainRepo();
}
