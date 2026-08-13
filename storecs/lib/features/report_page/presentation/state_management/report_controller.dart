import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/report_page/domain/entities/get_report_of_supervisor_entities.dart';

import 'package:storecs/features/report_page/domain/repository/report_repository.dart';
import 'package:storecs/main.dart';

class ReportController {
  final ReportRepository repository;
  ReportController({required this.repository});

  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  final email = FirebaseAuth.instance.currentUser!.email;
  final id = FirebaseAuth.instance.currentUser!.uid;
  final Alerts alerts = Alerts(messengerKey);
  GetReportOfSupervisorEntities entities = const GetReportOfSupervisorEntities(
    empId: '',
    level: '',
    title: '',
    subTitle: '',
  );
  EmployeeInfoEntities perEntities = const EmployeeInfoEntities(
    id: '',
    email: '',
    name: '',
    phone: '',
    userPic: '',
    level: '',
  );

  Future<void> storeReport() async {
    String employeeLevel =
        fetchEmployeeInfoDashBoardController.blocEntities.level;
    if (employeeLevel.trim().isEmpty) {
      /* check if the level is Supervisor or not*/
      employeeLevel = perEntities.level.isNotEmpty
          ? perEntities.level
          : 'Supervisor';
    }
    print('is supervisor? $employeeLevel');
    if (title.text.isEmpty || subTitle.text.isEmpty) {
      final error = 'Please insert the require fields.';
      alerts.ifErrors(error);
    } else {
      Loader.startLoading();
      try {
        final report = 'Report has been created.';
        await repository.reportRepository(
          id,
          email!,
          employeeLevel,
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

  Future<GetReportOfSupervisorEntities> getSuperReport(String level) async {
    try {
      final theReport = await repository.getReportRepository(level);
      entities = theReport;
      return entities;
    } on PlatformException catch (e) {
      print('The Error Is: ${e.message.toString()}');
      throw e.toString();
    } catch (e) {
      Loader.stopLoading();
      print("Something went wrong. $e");
      throw e.toString();
    } finally {
      Loader.stopLoading();
    }
  }

  void clearUi() {
    title.clear();
    subTitle.clear();
  }
}
