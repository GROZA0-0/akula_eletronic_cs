import 'package:flutter/material.dart';
import 'package:storecs/features/order_purchased_history/presentation/widgets/order_purchased_history_widgets.dart';

class OrderPurchasedHistory extends StatefulWidget {
  const OrderPurchasedHistory({super.key});

  @override
  State<OrderPurchasedHistory> createState() => _OrderPurchasedHistoryState();
}

class _OrderPurchasedHistoryState extends State<OrderPurchasedHistory> {
  @override
  Widget build(BuildContext context) {
    return OrderPurchasedHistoryWidgets();
  }
}
