import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_controller.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_event.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_state.dart';
import 'package:storecs/main.dart';

class ProfitLossLogsWidget extends StatefulWidget {
  const ProfitLossLogsWidget({super.key});

  @override
  State<ProfitLossLogsWidget> createState() => _ProfitLossLogsWidgetState();
}

class _ProfitLossLogsWidgetState extends State<ProfitLossLogsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(child: Text("Profit / loss Page", style: textAppBar)),
        iconTheme: IconThemeData(color: white),
      ),
      body: SafeArea(
        child: FadeInUp(
          child: Center(
            child: Container(
              margin: screenSize,
              width: size.width * 0.90,
              child: Column(children: [orderColumn(), TransactionLogsWidget()]),
            ),
          ),
        ),
      ),
    );
  }

  Widget orderColumn() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.01,
        vertical: size.height * 0.01,
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OrderTitle(text: 'OrderId'),
          OrderTitle(text: 'Order Details'),
          OrderTitle(text: 'Order Type'),
          OrderTitle(text: 'Sold/Refund By'),
          OrderTitle(text: 'Log Order at'),
        ],
      ),
    );
  }
}

class OrderTitle extends StatelessWidget {
  final String text;
  const OrderTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textBodiesStyle);
  }
}

class TransactionLogsWidget extends StatelessWidget {
  const TransactionLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return transactionLogsWidgetLayout();
  }

  Widget transactionLogsWidgetLayout() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: white),
        ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ProfitLossLogsBloc(sl<ProfitLossController>())
                    ..add(ProfitLossLogsBlocEventLoading()),
            ),
          ],
          child: BlocBuilder<ProfitLossLogsBloc, ProfitLossLogsBlocState>(
            builder: (context, state) {
              if (state is ProfitLossLogsBlocStateLoading) {
                return loadingStateBlocMethod(size);
              } else if (state is ProfitLossLogsBlocStateError) {
                return Center(child: Text(state.err, style: textBodiesStyle2));
              } else if (state is ProfitLossLogsBlocStateLoaded) {
                List<ProfitLossEntities> list = List.from(state.entities);
                return tranInfo(list);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget tranInfo(List<ProfitLossEntities> list) {
    final Alerts alerts = Alerts(messengerKey);
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final profit = list[index].orderType == 'Purchased';
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: size.height * 0.005,
            horizontal: size.width * 0.01,
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  orderIdTxt(list, index, alerts),
                  totalPriceTxt(list, index),
                  profit
                      ? PurhcaseRefundSectionWidget(
                          orderType: list[index].orderType,
                          color: greenColor,
                          icon: FontAwesomeIcons.arrowUp,
                        )
                      : PurhcaseRefundSectionWidget(
                          orderType: list[index].orderType,
                          color: redColor,
                          icon: FontAwesomeIcons.arrowDown,
                        ),
                  SizedBox(
                    width: size.width * 0.13,

                    child: Text(list[index].fullName, style: textBodiesStyle),
                  ),
                  createdAtTxt(list, index),
                ],
              ),
              Divider(color: white),
            ],
          ),
        );
      },
    );
  }

  Widget createdAtTxt(List<ProfitLossEntities> list, int index) {
    return SizedBox(
      child: Text(
        DateFormat('yyyy/MM/dd hh:mm:ss a').format(list[index].createdAt!),
        style: textBodiesStyle,
      ),
    );
  }

  Widget totalPriceTxt(List<ProfitLossEntities> list, int index) => SizedBox(
    width: size.width / 14,
    child: Text(
      '${list[index].totalPrice.toStringAsFixed(2)} JOD',
      style: textBodiesStyle,
    ),
  );

  Widget orderIdTxt(List<ProfitLossEntities> list, int index, Alerts alerts) =>
      GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: list[index].orderId));
          alerts.ifSuccess('Order ID Copied !');
        },
        child: Text(list[index].orderId, style: textBodiesStyle),
      );
}

class PurhcaseRefundSectionWidget extends StatelessWidget {
  final String orderType;
  final Color color;
  final IconData icon;
  const PurhcaseRefundSectionWidget({
    super.key,

    required this.orderType,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width / 15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            orderType,
            style: GoogleFonts.aleo(color: color, fontWeight: FontWeight.w400),
          ),
          Icon(icon, color: color),
        ],
      ),
    );
  }
}
