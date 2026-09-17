import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/settings_page/domain/repository/staff_permissions_repository.dart';
import 'package:storecs/main.dart';

class StaffPermissionsController extends ChangeNotifier {
  final StaffPermissionsRepository repository;
  StaffPermissionsController({required this.repository});
  final TextEditingController newPIN = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);
  bool pinRequired = true;
  Map<String, List<String>> hasAccess = {};

  final List<String> allLevels = [
    'Manager',
    'Cashier',
    'Sales',
    'Supervisor',
    'Q/A',
    'HR',
    'IT',
    'Accountant',
    'Warehouse Keeper',
    'Team Leader',
  ];

  Future<void> storeActions() async {
    Loader.startLoading();
    try {
      await repository.saveStaffPermissionRepositoy(
        pinRequired,
        newPIN.text.trim(),

        hasAccess,
      );
      Loader.stopLoading();
      alerts.ifSuccess('Staff Permissions Stored !');
      notifyListeners();
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }

  void toggleLevelForPage(String pageKey, String level) {
    hasAccess.putIfAbsent(pageKey, () => []);
    if (hasAccess[pageKey]!.contains(level)) {
      hasAccess[pageKey]!.remove(level);
    } else {
      hasAccess[pageKey]!.add(level);
    }
    notifyListeners();
  }

  Future<void> getActions() async {
    try {
      final data = await repository.getStaffPermissionsRepo();
      pinRequired = data.pinRequired;
      hasAccess = data.hasAccess;

      notifyListeners();
      // print('Parsed restrictedActions: ${data.restrictedActions}');
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }
}
