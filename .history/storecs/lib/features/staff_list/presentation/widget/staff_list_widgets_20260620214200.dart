import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/config/call_controller.dart';

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
          // margin: screenSize,
          width: size.width / 1.2,
          height: size.height / 2,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
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
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Employee Picture',
                                  style: textBodiesStyle,
                                ),
                                sizeBoxWidth(size.width * 0.165),
                                Text('Employee Name', style: textBodiesStyle),
                                sizeBoxWidth(size.width * 0.165),
                                Text(
                                  'Employee Phone number',
                                  style: textBodiesStyle,
                                ),
                                sizeBoxWidth(size.width * 0.165),
                                Text(
                                  'Employee department',
                                  style: textBodiesStyle,
                                ),
                              ],
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.02,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: buildProfileImage(
                                            state.entities[index].pic,
                                            index,
                                          ),
                                        ),

                                        SizedBox(
                                          width: size.width * 0.1,

                                          child: Text(
                                            state.entities[index].name,
                                            style: textBodiesStyle,
                                          ),
                                        ),

                                        SizedBox(
                                          width: size.width * 0.1,

                                          child: Text(
                                            state.entities[index].phone,
                                            style: textBodiesStyle,
                                          ),
                                        ),

                                        SizedBox(
                                          width: size.width * 0.1,

                                          child: Text(
                                            state.entities[index].level,
                                            style: textBodiesStyle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(color: white),
                                ],
                              );
                            },
                          ),
                        ],
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

  Widget buildProfileImage(String base64Image, int index) {
    if (base64Image.isEmpty) {
      return GestureDetector(
        onTap: () => print(staffListController.entities[index].name),
        child: const CircleAvatar(
          backgroundColor: grey,
          radius: 20,
          child: Icon(color: white, Iconsax.user),
        ),
      );
    } else {
      try {
        String sanitizedBase64 = base64Image.contains(',')
            ? base64Image.split(',').last
            : base64Image;

        sanitizedBase64 = sanitizedBase64.replaceAll(RegExp(r'\s+'), '');
        final bytes = base64Decode(sanitizedBase64);
        return GestureDetector(
          onTap: () =>
              print(fetchEmployeeInfoDashBoardController.entities.value.name),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: white),
            ),
            child: CircleAvatar(
              radius: 20,
              // backgroundColor: invisible,
              backgroundImage: MemoryImage(bytes),
            ),
          ),
        );
      } catch (e) {
        print("error rending base64 : $e");
        return const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.error_outline, color: white, size: 16),
        );
      }
    }
  }
}
