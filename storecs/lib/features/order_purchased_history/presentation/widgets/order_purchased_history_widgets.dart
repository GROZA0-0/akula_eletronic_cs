import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_bloc/order_purchased_history_bloc.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_bloc/order_purchased_history_bloc_event.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_bloc/order_purchased_history_bloc_state.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_controller.dart';

class OrderPurchasedHistoryWidgets extends StatefulWidget {
  const OrderPurchasedHistoryWidgets({super.key});

  @override
  State<OrderPurchasedHistoryWidgets> createState() =>
      _OrderPurchasedHistoryWidgetsState();
}

class _OrderPurchasedHistoryWidgetsState
    extends State<OrderPurchasedHistoryWidgets> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(
          child: Text("Orders Sold Historical", style: textAppBar),
        ),
        iconTheme: IconThemeData(color: white),
      ),
      body: SafeArea(
        child: FadeInUp(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => OrderPurchasedHistoryBloc(
                  sl<OrderPurchasedHistoryController>(),
                )..add(OrderPurchasedHistoryBlocEventLoading()),
              ),
            ],
            child:
                BlocBuilder<
                  OrderPurchasedHistoryBloc,
                  OrderPurchasedHistoryBlocState
                >(
                  builder: (context, state) {
                    if (state is OrderPurchasedHistoryBlocStateLoading) {
                      return loadingStateBlocMethod(size);
                    } else if (state is OrderPurchasedHistoryBlocStateEmpty) {
                      return noOrderReviewedtext();
                    } else if (state is OrderPurchasedHistoryBlocStateError) {
                      return Text(state.err, style: textBodiesStyle2);
                    } else if (state is OrderPurchasedHistoryBlocStateLoaded) {
                      final groupedMap = state.entities;
                      final dateHeadersList = groupedMap.keys.toList();
                      return ListSoldOrderData(
                        dateHeadersList: dateHeadersList,
                        groupedMap: groupedMap,
                      );
                    }
                    return Container();
                  },
                ),
          ),
        ),
      ),
    );
  }

  Widget noOrderReviewedtext() {
    return Container(
      margin: EdgeInsets.only(top: size.height * 4),
      child: Text(
        "No Orders in Purchased",
        style: GoogleFonts.aleo(
          fontSize: 30,
          color: black,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

class ListSoldOrderData extends StatelessWidget {
  const ListSoldOrderData({
    super.key,
    required this.dateHeadersList,
    required this.groupedMap,
  });

  final List<String> dateHeadersList;
  final Map<String, List<OrderPurchasedHistoryEntities>> groupedMap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: dateHeadersList.length,
      itemBuilder: (context, outerIndex) {
        String dateHeader = dateHeadersList[outerIndex];

        List<OrderPurchasedHistoryEntities> orderEntities =
            groupedMap[dateHeader]!;

        return Column(
          children: [
            dateHeaderData(dateHeader),

            listOfOrdersData(orderEntities),
          ],
        );
      },
    );
  }

  Widget listOfOrdersData(List<OrderPurchasedHistoryEntities> orderEntities) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orderEntities.length,
      itemBuilder: (context, innerIndex) {
        final order = orderEntities[innerIndex];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: grey, width: 5),
          ),
          padding: const EdgeInsets.all(12.0),
          margin: EdgeInsets.symmetric(
            vertical: size.height * 0.02,
            horizontal: size.width * 0.1,
          ),
          height: size.height / 1.3,
          width: size.width / 1.3,
          child: Column(
            children: [
              Text(
                'Order ID: ${order.orderId}',
                style: GoogleFonts.aleo(
                  color: white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Divider(),
              Column(
                children: [
                  SizedBox(
                    width: size.width,
                    child: Text(
                      'Items: ${order.items.length}',
                      style: GoogleFonts.aleo(fontSize: 21, color: white),
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: Text(
                      'Total Price: ${order.totalPrice.toStringAsFixed(2)} JOD',
                      style: GoogleFonts.aleo(fontSize: 20, color: white),
                    ),
                  ),
                ],
              ),
              sizeBoxHeight(size.height * 0.02),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: grey, width: 3),
                ),
                width: size.width,
                height: size.height / 1.89,
                child: SingleChildScrollView(
                  child: Column(
                    children: order.items.map((item) {
                      return Container(
                        // color: redColor,
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.02,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: invisible,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: white,
                                ),
                                width: size.width / 11,
                                height: size.height / 11,
                                child: Image.memory(
                                  base64Decode(item.image),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            sizeBoxWidth(size.width * 0.002),
                            Expanded(
                              child: Text(
                                "${item.brand} ${item.name} x${item.quantity}",
                                style: GoogleFonts.aleo(
                                  fontSize: 14,
                                  color: white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${item.price} JOD",
                              style: GoogleFonts.aleo(
                                fontSize: 14,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dateHeaderData(String dateHeader) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(),
        Container(
          width: size.width / 2,
          height: size.height * 0.076,
          padding: EdgeInsets.all(size.height * 0.012),
          child: Text(
            dateHeader,
            style: GoogleFonts.aleo(
              fontSize: 20,
              color: white,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
