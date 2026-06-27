import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:storecs/Core/Styles/alerts.dart';

import 'package:storecs/Core/styles/Strings.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/colors.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_bloc/staff_list_bloc.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_bloc/staff_list_bloc_event.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_bloc/staff_list_bloc_state.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';
import 'package:storecs/main.dart';

class StaffListWidgets extends StatefulWidget {
  const StaffListWidgets({super.key});

  @override
  State<StaffListWidgets> createState() => _StaffListWidgetsState();
}

class _StaffListWidgetsState extends State<StaffListWidgets> {
  @override
  Widget build(BuildContext context) {
    final Alerts alerts = Alerts(messengerKey);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: Text(StaffList, style: textAppBar),
      ),
      body: SafeArea(
        child: Container(
          margin: screenSize,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: white),
              ),
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        StaffListBloc(Get.find<StaffListController>())
                          ..add(StaffListBlocEventLoading()),
                  ),
                ],
                child: BlocBuilder<StaffListBloc, StaffListBlocState>(
                  builder: (context, state) {
                    if (state is StaffListBlocStateLoading) {
                      return loadingStateBlocMethod(size);
                    } else if (state is StaffListBlocStateError) {
                      return alerts.ifErrors(state.err.toString());
                    } else if (state is StaffListBlocStateLoaded) {
                      List<StaffListEntities> list = List.from(state.entities);
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, index) {},
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
