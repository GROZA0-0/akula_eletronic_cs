import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/domain/repository/staff_list_repo.dart';
import 'package:storecs/main.dart';

class StaffListController {
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
    "Supervisor",
    "Q/A",
    "Cashier",
    "Sales",
    "HR",
    "Accountant",
    "IT",
    "Warehouse keeper",
  ];
  final selectedlevel = ''.obs;
  void changeLevel(String level) => selectedlevel.value = level;
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtField = TextEditingController();

  Future<List<StaffListEntities>> getStaff() async {
    try {
      final staff = await repository.toStaffListdomainRepo();
      // print("info of user [$staff]");
      entities = staff.toList();
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
        selectedlevel.value,
      );
      specificEntities.phone = txtPhone.text.trim();
      specificEntities = updateStaff;
      Loader.stopLoading();
      alerts.ifSuccess('Employee Updated !');
      clearFields();
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
      alerts.ifSuccess('Employee Account Terminated !');
      Navigator.pop(navigator!.context);
      return deleteAcc;
    } catch (e) {
      print("error in staff delete account controller $e");
      throw e.toString();
    }
  }

  void clearFields() {
    txtPhone.clear();
    selectedlevel.value.isEmpty;
  }
}
