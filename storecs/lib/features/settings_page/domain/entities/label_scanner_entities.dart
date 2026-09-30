import 'package:equatable/equatable.dart';

class LabelScannerEntities extends Equatable {
  final Map<String, bool> scannerInput;
  final String scanTrigger;
  final String keyCaptureDelay;
  final Map<String, List<bool>> listOfScanInput;

  const LabelScannerEntities({
    required this.scannerInput,
    required this.scanTrigger,
    required this.keyCaptureDelay,
    required this.listOfScanInput,
  });

  @override
  List<Object?> get props => [
    scannerInput,
    scanTrigger,
    keyCaptureDelay,
    listOfScanInput,
  ];
}
