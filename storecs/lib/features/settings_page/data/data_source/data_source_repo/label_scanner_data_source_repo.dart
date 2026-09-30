import 'package:storecs/features/settings_page/data/model/label_scanner_model.dart';

abstract class LabelScannerDataSourceRepo {
  Future<void> storelabelScannerDataSourceRepo(
    Map<String, bool> scannerInput,
    String scanTrigger,
    String keyCaptureDelay,
    Map<String, List<bool>> listOfScanInput,
  );
  Future<LabelScannerModel> fetchlabelScannerDataSourceRepo();
}
