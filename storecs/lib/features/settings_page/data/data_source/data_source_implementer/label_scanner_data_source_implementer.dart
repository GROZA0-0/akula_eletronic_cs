import 'package:dio/dio.dart';
import 'package:storecs/Core/config/env.dart';
import 'package:storecs/features/settings_page/data/data_source/data_source_repo/label_scanner_data_source_repo.dart';
import 'package:storecs/features/settings_page/data/model/label_scanner_model.dart';

class LabelScannerDataSourceImplementer implements LabelScannerDataSourceRepo {
  final Dio dio;
  LabelScannerDataSourceImplementer({required this.dio});
  final options = Options(
    contentType: 'application/json',
    validateStatus: (status) => status! < 600,
  );
  @override
  Future<LabelScannerModel> fetchlabelScannerDataSourceRepo() async {
    final getScanner = '${Env.baseURL}fetchlabelScannerRoute';
    final res = await dio.get(getScanner, options: options);
    if (res.statusCode == 200 || res.statusCode == 201) {
      if (res.data == null) {
        return LabelScannerModel.emptyLabelScannerModel();
      } else {
        final data = res.data is Map ? res.data['data'] : res.data;
        // print('get label data from data source $data');
        return LabelScannerModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with fetching payment actions ? : ${res.statusCode}",
      );
    }
  }

  @override
  Future<void> storelabelScannerDataSourceRepo(
    Map<String, bool> scannerInput,
    String scanTrigger,
    String keyCaptureDelay,
    Map<String, List<bool>> listOfScanInput,
  ) async {
    final storeScanner = '${Env.baseURL}storelabelScannerDataRoute';
    final data = {
      "scannerInput": scannerInput,
      "scanTrigger": scanTrigger,
      "keyCaptureDelay": keyCaptureDelay,
      "listOfScanInput": listOfScanInput,
    };
    final res = await dio.post(storeScanner, data: data, options: options);
    if (res.statusCode == 201 || res.statusCode == 200) {
      if (res.data == null) {
        LabelScannerModel.emptyLabelScannerModel();
      } else {
        final data = res.data['data'];
        LabelScannerModel.fromJson(data);
      }
    } else {
      throw Exception(
        "Any issue with creating label scanner actions ? : ${res.statusCode}",
      );
    }
  }
}
