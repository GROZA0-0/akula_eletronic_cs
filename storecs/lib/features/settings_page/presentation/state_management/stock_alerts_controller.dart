import 'package:flutter/material.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/styles/loader.dart';
import 'package:storecs/features/settings_page/domain/entities/stocks_Alerts_entities/low_stock_item_entities.dart';
import 'package:storecs/features/settings_page/domain/repository/stock_alerts_repository.dart';
import 'package:storecs/main.dart';

class StockAlertsController extends ChangeNotifier {
  final StockAlertsRepository repository;
  StockAlertsController({required this.repository});

  final Alerts alerts = Alerts(messengerKey);
  Map<String, TextEditingController> thresholdController = {
    'Phones': TextEditingController(text: '5'),
    'Tablates': TextEditingController(text: '5'),
    "Tv's & Monitors": TextEditingController(text: '3'),
    'Accessories': TextEditingController(text: '10'),
    'PS5': TextEditingController(text: '3'),
    "Pc's Components": TextEditingController(text: '5'),
  };
  List<LowStockItemEntities> lowStockItems = [];
  bool isLoading = false;

  Future<void> storeThreSholdAlerts() async {
    Loader.startLoading();
    final threshold = thresholdController.map(
      (category, controller) =>
          MapEntry(category, int.parse(controller.text.trim())),
    );
    try {
      await repository.saveStockThresholdsRepository(threshold);
      Loader.stopLoading();
      alerts.ifSuccess('Stock Alerts Threshold Stored !');
      notifyListeners();
    } catch (e) {
      Loader.stopLoading();
      print("error in store threshold Stock Alerts controller $e");
      throw e.toString();
    }
  }

  Future<void> getThreSholdAlerts() async {
    try {
      final Map<String, int> threshold = await repository
          .getStockThresholdsRepository();
      threshold.forEach((category, value) {
        if (thresholdController.containsKey(
          category,
        ) /* check if the TextEditingController already exists for this category */ ) {
          thresholdController[category]!.text = value.toString();
        } else {
          /* create a new TextEditingController if the key not exist in the back end */
          thresholdController[category] = TextEditingController(
            text: value.toString(),
          );
        }
      });
      notifyListeners();
    } catch (e) {
      Loader.stopLoading();
      print("error in get threshold Stock Alerts controller $e");
      throw e.toString();
    }
  }

  Future<List<LowStockItemEntities>> getLowStockAlerts() async {
    try {
      lowStockItems = await repository.getLowStockItemsRepository();
      notifyListeners();
      return lowStockItems;
    } catch (e) {
      Loader.stopLoading();
      print("error in get threshold low Stock Alerts controller $e");
      throw e.toString();
    }
  }
}
