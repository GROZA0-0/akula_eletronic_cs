import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';
import 'package:storecs/main.dart';

class StaffListController extends ChangeNotifier {
  final StaffListRepo repository;
  StaffListController({required this.repository});

  RxBool loading = false.obs;
  List<StaffListEntities> entities = [];
  Alerts alerts = Alerts(messengerKey);
  StaffListEntities specificEntities = StaffListEntities(
    id: '',
    email: '',
    name: '',
    phone: '',
    pic: '',
    level: '',
  );
  final List<String> staffLevels = [
    "Manager",
    "Team Leader",
    "Supervisor",
    "Q/A",
    "Cashier",
    "Sales",
    "HR",
    "Accountant",
    "IT",
    "Warehouse keeper",
  ];
  String selectedlevel = '';
  void changeLevel(String level) {
    selectedlevel = level;
    notifyListeners();
  }

  TextEditingController txtPhone = TextEditingController();

  Future<List<StaffListEntities>> getStaff() async {
    try {
      final staff = await repository.toStaffListdomainRepo();
      // print("info of user [$staff]");
      entities = staff.toList();
      notifyListeners();
      return staff;
    } catch (e) {
      print("error in dashboard controller $e");
      throw e.toString();
    }
  }

  Future<StaffListEntities> updateStaffInfo(String id) async {
    Loader.startLoading();
    try {
      final updateStaff = await repository.toUpdateStaffRepository(
        id,
        txtPhone.text.trim(),
        selectedlevel,
      );
      specificEntities.phone = txtPhone.text.trim();
      // specificEntities.level = staffLevels[index];
      specificEntities = updateStaff;
      Loader.stopLoading();
      alerts.ifSuccess('Employee Updated !');
      clearFields();
      notifyListeners();
      return updateStaff;
    } catch (e) {
      print("error in staff update info controller $e");
      throw e.toString();
    }
  }

  Future<StaffListEntities> terminateStaffAccount(String id) async {
    Loader.startLoading();
    try {
      final deleteAcc = await repository.toTerminateStaffAccountRepository(id);
      Loader.stopLoading();
      alerts.ifSuccess('Employee Account Has Been Terminated !');
      notifyListeners();
      return deleteAcc;
    } catch (e) {
      print("error in staff delete account controller $e");
      throw e.toString();
    }
  }

  void clearFields() {
    txtPhone.clear();
    selectedlevel.isEmpty;
  }
}
