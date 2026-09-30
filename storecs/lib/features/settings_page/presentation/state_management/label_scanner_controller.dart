import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';

import 'package:storecs/features/settings_page/domain/repository/label_scanner_repository.dart';
import 'package:storecs/main.dart';

class LabelScannerController extends ChangeNotifier {
  final LabelScannerRepository repository;
  LabelScannerController({required this.repository});

  Map<String, List<bool>> listOfScanInput = {};
  Map<String, bool> scannerInput = {};

  final TextEditingController keyCaptureDelay = TextEditingController();
  String scanTriggerSelected = 'Enter Key';
  final Alerts alerts = Alerts(messengerKey);
  final List<String> scanTriggerOptions = [
    'Enter Key',
    'Tab Key',
    'Custom Suffix',
  ];
  void changeScanTrigger(String value) {
    scanTriggerSelected = value;
    notifyListeners();
  }

  Future<void> storeActions() async {
    Loader.startLoading();
    try {
      await repository.storelabelScannerDataSourceRepo(
        scannerInput,
        scanTriggerSelected,
        keyCaptureDelay.text.trim(),
        listOfScanInput,
      );
      Loader.stopLoading();
      alerts.ifSuccess('Label Scanner Options Stored !');
      notifyListeners();
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }

  Future<void> getActions() async {
    try {
      final data = await repository.fetchlabelScannerDataSourceRepo();
      // print('get label data from controller $data');
      scannerInput = data.scannerInput;
      listOfScanInput = data.listOfScanInput;
      keyCaptureDelay.text = data.keyCaptureDelay;
      if (scanTriggerOptions.contains(data.scanTrigger)) {
        scanTriggerSelected = data.scanTrigger;
      } else {
        scanTriggerSelected = 'Enter Key';
      }
      notifyListeners();
    } on PlatformException catch (e) {
      Loader.stopLoading();
      alerts.ifErrors(e.message.toString());
    } finally {
      Loader.stopLoading();
    }
  }
}
