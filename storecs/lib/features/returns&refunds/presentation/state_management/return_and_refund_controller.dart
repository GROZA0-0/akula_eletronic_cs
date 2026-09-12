import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/features/returns&refunds/data/models/items_details_model.dart';
import 'package:storecs/features/returns&refunds/data/models/refund_item_model.dart';
import 'package:storecs/features/returns&refunds/domain/entities/orders_details_entities.dart';
import 'package:storecs/features/returns&refunds/domain/repository/order_details_repo.dart';
import 'package:storecs/features/returns&refunds/domain/repository/store_return_and_refund_info_repository.dart';
import 'package:storecs/main.dart';

enum ReturnStatus { initial, loading, success, error }

class ReturnAndRefundController extends ChangeNotifier {
  final StoreReturnAndRefundInfoRepository refundRepo;
  final OrderDetailsRepo repo;
  ReturnAndRefundController({required this.repo, required this.refundRepo});
  final Alerts alerts = Alerts(messengerKey);
  ReturnStatus status = ReturnStatus.initial;
  final errMessage = '';

  final paymentMethod = 'N/A'.obs;
  final originalTotal = 0.0.obs;
  List<ItemsDetailsModel> itemsDetailsModel =
      []; /* will show the items of the order */
  List<RefundItemModel> refundItemModel = [];
  bool restoreInventory = false; /* make a restore or not  */
  String refundReason = '';
  OrdersDetailsEntities entities = OrdersDetailsEntities(
    /* info the order */
    orderId: '',
    items: [],
    totalPrice: 0.0,
    time: DateTime.now(),
  );
  TextEditingController orderIdText = TextEditingController();

  Future<void> getOrderBySearchingOnOrderId() async {
    /* use to search of the order */
    final searchOrderId = orderIdText.text.trim();
    if (searchOrderId.isEmpty) {
      /* if clicked on search, give alert */
      final error = "Please enter an Order ID.";
      status = ReturnStatus.error;
      alerts.ifErrors(error);
      notifyListeners();
    }
    status = ReturnStatus.loading;

    try {
      final order = await repo.getOrderDetails(
        searchOrderId,
      ); /* call the repository method */
      if (order.orderId.isEmpty || order.items.isEmpty) {
        /* check if the order is exist in database or not */
        final error = 'Order not found.';
        status = ReturnStatus.error;
        alerts.ifErrors(error);
        notifyListeners();
      }
      entities = order; /* inject the order method in entities variable */
      originalTotal.value = order.totalPrice;
      restoreInventory = false;
      refundReason = '';
      itemsDetailsModel.assignAll(
        /* reseting the select and return qty field to avoid the order caching after searchin on another order */
        order.items.map((item) {
          item.isSelected = false;
          item.returnQuantity = 0;
          return item;
        }).toList(),
      );
      status = ReturnStatus.success;
      notifyListeners();
    } catch (e) {
      print("error in details of order details controller $e");
      throw e.toString();
    }
  }

  void itemSection(int idx, bool vlu) {
    final item = itemsDetailsModel[idx]; /* check on any item */

    item.isSelected = vlu;
    if (vlu && item.returnQuantity == 0) {
      /* return the defualt values */
      item.returnQuantity = item.quantity;
    } else if (!vlu) {
      item.returnQuantity = 0;
    }
    itemsDetailsModel[idx] = item; /* for reactive */
    notifyListeners();
  }

  void updateReturnQty(int idx, int qty) {
    final item = itemsDetailsModel[idx];
    if (qty > item.quantity) {
      qty = item.quantity;
    } else if (qty < 0) {
      qty = 0;
    }
    item.returnQuantity = qty;
    item.isSelected = qty > 0;

    itemsDetailsModel[idx] = item;
    notifyListeners();
  }

  bool get isAllSelected =>
      itemsDetailsModel.isNotEmpty &&
      itemsDetailsModel.every((item) => item.isSelected);
  void toggleSelectAll(bool val) {
    /* use to select all  */
    for (int i = 0; i < itemsDetailsModel.length; i++) {
      /* migrating on each item and make the selection true */
      var item = itemsDetailsModel[i];
      item.isSelected = val;
      item.returnQuantity = val ? item.quantity : 0;
      itemsDetailsModel[i] = item; /* update items */
    }
    notifyListeners();
  }

  double get calculatedReturnAmount {
    double total = 0.0;
    for (var item in itemsDetailsModel) {
      if (item.isSelected) {
        total += (item.price * item.returnQuantity);
      }
    }
    return total;
  }

  Future<void> submitReturn() async {
    final selectedReturns = itemsDetailsModel
        .where((item) => item.isSelected)
        .toList();

    if (selectedReturns.isEmpty) {
      alerts.ifErrors('Please select at least one item to return');
      return;
    }

    final List<RefundItemModel> payload = selectedReturns.map((item) {
      return RefundItemModel(
        id: item.id,
        pName: item.name,
        pCategory: item.category,
        returnQuantity: item.returnQuantity,
        refundPrice: (item.price * item.returnQuantity),
      );
    }).toList();

    try {
      status = ReturnStatus.loading;
      await refundRepo.storeTheRefundInfoRepo(
        entities.orderId,
        restoreInventory,
        refundReason,
        calculatedReturnAmount,
        payload,
      );
      await profitLossController.storeCase(
        entities.orderId,
        'Refunded',
        calculatedReturnAmount,
      );
      status = ReturnStatus.success;
      final mess = 'Refund success';
      alerts.ifSuccess(mess);
      cleanUi();
    } catch (e) {
      status = ReturnStatus
          .error; /* Switch status back to form view so they can try again */
      print("Error submitting return: $e");

      alerts.ifErrors('Submission Failed');
    }
    notifyListeners();
  }

  void cleanUi() {
    orderIdText.clear();
    itemsDetailsModel = [];
    refundReason = '';
    refundItemModel = [];
    restoreInventory = false;
    status = ReturnStatus.initial;
  }
}
