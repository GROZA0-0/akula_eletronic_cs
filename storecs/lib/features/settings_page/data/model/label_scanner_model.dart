import 'package:storecs/features/settings_page/domain/entities/label_scanner_entities.dart';

class LabelScannerModel {
  final Map<String, bool> scannerInput;
  final String scanTrigger;
  final String keyCaptureDelay;
  final Map<String, List<bool>> listOfScanInput;

  LabelScannerModel({
    required this.scannerInput,
    required this.scanTrigger,
    required this.keyCaptureDelay,
    required this.listOfScanInput,
  });

  static LabelScannerModel emptyLabelScannerModel() {
    return LabelScannerModel(
      scannerInput: {},
      scanTrigger: '',
      keyCaptureDelay: '',
      listOfScanInput: {},
    );
  }

  static Map<String, bool> parseScannerInput(dynamic value) {
    if (value is Map) {
      return value.map((key, val) => MapEntry(key.toString(), val == true));
    }
    return {};
  }

  static Map<String, List<bool>> parseListOfScanInput(dynamic value) {
    if (value is Map) {
      return value.map((key, val) {
        final List<bool> boolList = [];
        if (val is List) {
          for (var item in val) {
            // Safely convert to bool
            if (item is bool) boolList.add(item);
            if (item == 'true' || item == 1) boolList.add(true);
            if (item == 'false' || item == 0) boolList.add(false);
          }
        }
        return MapEntry(key.toString(), boolList);
      });
    }
    return {};
  }

  factory LabelScannerModel.fromJson(Map<String, dynamic> map) {
    // print('get label data $map');
    return LabelScannerModel(
      scannerInput: parseScannerInput(map['scannerInput']),
      scanTrigger: map['scanTrigger'] ?? '',
      keyCaptureDelay: map['keyCaptureDelay'] ?? '',
      listOfScanInput: parseListOfScanInput(map['listOfScanInput']),
    );
  }

  LabelScannerEntities toLabelScannerEntities() {
    return LabelScannerEntities(
      scannerInput: scannerInput,
      scanTrigger: scanTrigger,
      keyCaptureDelay: keyCaptureDelay,
      listOfScanInput: listOfScanInput,
    );
  }
}
