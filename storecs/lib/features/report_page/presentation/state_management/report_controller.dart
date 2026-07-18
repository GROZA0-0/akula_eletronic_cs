import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/report_page/domain/repository/report_repository.dart';
import 'package:storecs/main.dart';

class ReportController extends GetxController {
  final ReportRepository repository;
  ReportController({required this.repository});

  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);

  Future<void> storeReport() async {
    if (title.text.isEmpty || subTitle.text.isEmpty) {
      final error = 'Please insert the require fields.';
      alerts.ifErrors(error);
    } else {
      Loader.startLoading();
      try {
        final report = 'Report has been created.';
        await repository.reportRepository(
          title.text.trim(),
          subTitle.text.trim(),
        );
        clearUi();
        alerts.ifSuccess(report);
      } on PlatformException catch (e) {
        print('The Error Is: ${e.message.toString()}');
        alerts.ifErrors(e.message.toString());
        Loader.stopLoading();
      } catch (e) {
        Loader.stopLoading();
        print("Something went wrong. $e");
        alerts.ifErrors("Something went wrong.");
      } finally {
        Loader.stopLoading();
      }
    }
  }

  void clearUi() {
    title.clear();
    subTitle.clear();
  }
}
