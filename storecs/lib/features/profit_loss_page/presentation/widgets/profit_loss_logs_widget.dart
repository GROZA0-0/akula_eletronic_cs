import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_controller.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_event.dart';
import 'package:storecs/features/profit_loss_page/presentation/state_management/profit_loss_logs_bloc/profit_loss_logs_bloc_state.dart';

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
        child: Container(
          margin: screenSize,
          width: double.infinity,
          child: Column(children: [orderColumn(), TransactionLogsWidget()]),
        ),
      ),
    );
  }

  Widget orderColumn() {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('OrderId', style: textBodiesStyle),
            Text('Order Details', style: textBodiesStyle),
            Text('Order Type', style: textBodiesStyle),
          ],
        ),
      ),
    );
  }
}

class TransactionLogsWidget extends StatelessWidget {
  const TransactionLogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FadeInUp(
        child: Container(
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
                  Center(child: Text(state.err, style: textBodiesStyle2));
                } else if (state is ProfitLossLogsBlocStateLoaded) {
                  List<ProfitLossEntities> list = List.from(state.entities);
                  return tranInfo(list);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget tranInfo(List<ProfitLossEntities> list) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        final profit = list[index].orderType == 'Purchased';
        return Container(
          margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  orderIdTxt(list, index),
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
                ],
              ),
              Divider(color: white),
            ],
          ),
        );
      },
    );
  }

  Text totalPriceTxt(List<ProfitLossEntities> list, int index) =>
      Text('${list[index].totalPrice} JOD', style: textBodiesStyle);

  Text orderIdTxt(List<ProfitLossEntities> list, int index) =>
      Text(list[index].orderId, style: textBodiesStyle);
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
    return Row(
      children: [
        Text(
          orderType,
          style: GoogleFonts.aleo(color: color, fontWeight: FontWeight.w400),
        ),
        Icon(icon, color: color),
      ],
    );
  }
}
