import 'package:storecs/features/settings_page/data/data_source/data_source_repo/label_scanner_data_source_repo.dart';
import 'package:storecs/features/settings_page/domain/entities/label_scanner_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/label_scanner_repository.dart';

class LabelScannerImeplementer implements LabelScannerRepository {
  final LabelScannerDataSourceRepo repo;
  LabelScannerImeplementer({required this.repo});

  @override
  Future<LabelScannerEntities> fetchlabelScannerDataSourceRepo() async {
    try {
      final model = await repo.fetchlabelScannerDataSourceRepo();
      return model.toLabelScannerEntities();
    } catch (e) {
      print("any errors in fetch LabelScannerImeplementer $e");
      throw e.toString();
    }
  }

  @override
  Future<void> storelabelScannerDataSourceRepo(
    Map<String, bool> scannerInput,
    String scanTrigger,
    String keyCaptureDelay,
    Map<String, List<bool>> listOfScanInput,
  ) async {
    try {
      await repo.storelabelScannerDataSourceRepo(
        scannerInput,
        scanTrigger,
        keyCaptureDelay,
        listOfScanInput,
      );
    } catch (e) {
      print("any errors in store LabelScannerImeplementer $e");
      throw e.toString();
    }
  }
}
