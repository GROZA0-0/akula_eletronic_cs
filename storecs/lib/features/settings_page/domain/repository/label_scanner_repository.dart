import 'package:storecs/features/settings_page/domain/entities/label_scanner_entities.dart';

abstract class LabelScannerRepository {
  Future<void> storelabelScannerDataSourceRepo(
    Map<String, bool> scannerInput,
    String scanTrigger,
    String keyCaptureDelay,
    Map<String, List<bool>> listOfScanInput,
  );
  Future<LabelScannerEntities> fetchlabelScannerDataSourceRepo();
}
