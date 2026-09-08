import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/issues_or_suggestions/domain/repository/feedback_repository.dart';
import 'package:storecs/main.dart';

class FeedbackController extends ChangeNotifier {
  final FeedbackRepository repository;
  FeedbackController({required this.repository});

  List<String> issueCategories = [
    'Price mismatch',
    'System lag',
    'Customer complaint',
    'Inventory issue',
    'Equipment',
    'Other',
  ];
  List<String> severity = ['Low', 'Medium', 'High'];
  String selectedIssueCategories = '';
  String selectedSeverity = '';

  /* Call notifyListeners() to update the value when call it */
  void changeIssue(String level) {
    selectedIssueCategories = level;
    notifyListeners();
  }

  void changeSeverit(String level) {
    selectedSeverity = level;
    notifyListeners();
  }

  final empId = FirebaseAuth.instance.currentUser!.uid;
  final empEmail = FirebaseAuth.instance.currentUser!.email;
  TextEditingController note = TextEditingController();
  final Alerts alerts = Alerts(messengerKey);

  Future<void> storeFeedback() async {
    if (selectedIssueCategories.isEmpty) {
      alerts.ifErrors('The issue is require');
    } else if (selectedSeverity.isEmpty) {
      alerts.ifErrors('The severity is require');
    } else {
      Loader.startLoading();
      try {
        await repository.storeFeedbackEntities(
          empId,
          empEmail!,
          selectedIssueCategories,
          selectedSeverity,
          note.text.trim(),
        );
        alerts.ifSuccess('Report has been sent');
        clearUi();
        notifyListeners();
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
    selectedIssueCategories = '';
    selectedSeverity = '';
    note.clear();
  }
}
