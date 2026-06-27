import 'package:get/get.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';

class StaffListController extends GetxController {
  final StaffListRepo repository;
  StaffListController({required this.repository});

  RxBool loading = false.obs;
  Rx<StaffListEntities> entities = StaffListEntities(
    id: '',
    name: '',
    phone: '',
    pic: '',
    level: '',
  ).obs;

  Future<StaffListEntities> getStaff() async {
    try {
      final staff = await repository.toStaffListdomainRepo();
      print("info of user [${staff.name}\n${staff.level}]");
      entities.value = staff;
      return staff;
    } catch (e) {
      print("error in dashboard controller $e");
      throw e.toString();
    }
  }
}
