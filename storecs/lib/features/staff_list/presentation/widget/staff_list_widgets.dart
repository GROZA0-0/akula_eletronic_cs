import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/Styles/alerts.dart';
import 'package:storecs/Core/config/account_status.dart';
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
  // bool isEdit = false;
  int? editingIndex;
  @override
  Widget build(BuildContext context) {
    final Alerts alerts = Alerts(messengerKey);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text(StaffList, style: textAppBar)),
      ),
      body: SafeArea(
        child: Container(
          margin: screenSize,
          width: double.infinity,
          // height: size.height / 1.1,
          child: Column(children: [empColumns(), empData(alerts)]),
        ),
      ),
    );
  }

  Widget empData(Alerts alerts) {
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
                    StaffListBloc(sl<StaffListController>())
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
                    itemBuilder: (context, index) {
                      final currentStatus = state.entities;
                      final employee = state.entities[index];
                      final bool isEditingTtisRow = editingIndex == index;
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: size.height * 0.005,
                        ),
                        child: Row(
                          children: [
                            sizeBoxWidth(size.width * 0.003),
                            empInfo(
                              employee,
                              index,
                              isEditingTtisRow,
                              currentStatus,
                            ),

                            SizedBox(width: size.width * 0.01),
                            EmpButtonActions(
                              onTap: () async {
                                if (isEditingTtisRow) {
                                  /* in edit mode, click on check to save */
                                  final updateStaff = await staffListController
                                      .updateStaffInfo(employee.id);
                                  setState(() {
                                    state.entities[index] =
                                        updateStaff; /* refresh to get the latest info */
                                    editingIndex = null;
                                  });
                                } else {
                                  setState(() {
                                    staffListController.txtPhone.text =
                                        employee.phone ?? '';
                                    staffListController.txtField.text =
                                        employee.level ?? '';
                                    editingIndex = index;
                                  });
                                }
                              },
                              color: isEditingTtisRow ? greenColor : white,
                              icon: isEditingTtisRow
                                  ? FontAwesomeIcons.check
                                  : Iconsax.edit,
                            ),
                            EmpButtonActions(
                              onTap: () => termniateStaffAccountDialog(
                                context,
                                employee,
                              ),
                              color: redColor,
                              icon: Iconsax.trash,
                            ),
                          ],
                        ),
                      );
                    },
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

  Expanded empInfo(
    StaffListEntities employee,
    int index,
    bool isEditingTtisRow,
    List<StaffListEntities> currentStatus,
  ) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05,
          vertical: size.height * 0.01,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: white, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /* Emp Pic */
            Container(
              margin: EdgeInsets.only(top: size.height * 0.004),
              child: buildProfileImage(employee.pic, index),
            ),
            /* Emp Name */
            SizedBox(
              width: size.width * 0.1,
              child: Text(employee.name, style: textBodiesStyle),
            ),
            /* Emp Phone */
            isEditingTtisRow
                ? EditUserDataTextFieldTemplate(
                    text: 'New Phone Number',
                    controller: staffListController.txtPhone,
                    icon: FontAwesomeIcons.squarePhone,
                  )
                : SizedBox(
                    width: size.width * 0.1,
                    child: Text(employee.phone ?? '', style: textBodiesStyle),
                  ),
            /* Emp Level */
            isEditingTtisRow
                ? DropdownButton<String>(
                    dropdownColor: grey,
                    hint: Text(
                      "Postions",
                      style: GoogleFonts.aleo(
                        color: white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    value: staffListController.selectedlevel.value.isEmpty
                        ? null
                        : staffListController.selectedlevel.value,
                    items: staffListController.staffLevels.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.aleo(
                            color: white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          staffListController.changeLevel(newValue);
                        });
                      }
                    },
                  )
                : SizedBox(
                    width: size.width * 0.1,
                    child: Text(employee.level ?? '', style: textBodiesStyle),
                  ),
            /* Emp Status */
            empStatus(currentStatus, index),
          ],
        ),
      ),
    );
  }

  Future<Object?> termniateStaffAccountDialog(
    BuildContext context,
    StaffListEntities employee,
  ) {
    final staffListBloc = context.read<StaffListBloc>();
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(parent: animation, curve: Curves.ease);
        return ScaleTransition(
          scale: curved,
          child: FadeTransition(opacity: curved, child: child),
        );
      },
      pageBuilder: (dialogContext, animation1, animation2) => BlocProvider.value(
        value: staffListBloc,
        child: Builder(
          builder: (innerContext) {
            return AlertDialog(
              backgroundColor: surfaceCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
                side: BorderSide(color: white),
              ),
              title: Text(
                "Terminate Staff.",
                style: GoogleFonts.aleo(
                  color: white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SingleChildScrollView(
                child: Text(
                  "Are You Sure You Want To Terminate ${employee.email} Account ?",
                  style: GoogleFonts.aleo(
                    color: white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    staffListController.terminateStaffAccount(employee.id);
                    innerContext.read<StaffListBloc>().add(
                      StaffListBlocEventLoading(),
                    );
                  },
                  child: const Text(
                    "Terminate",
                    style: TextStyle(color: redColor),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text("Back", style: TextStyle(color: blueGreen)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget empStatus(List<StaffListEntities> currentStatus, int index) {
    return Container(
      height: size.height * 0.03,
      clipBehavior: Clip.none,
      child: Container(
        width: size.width * 0.02,
        height: size.height * 0.02,
        decoration: BoxDecoration(
          color: currentStatus[index].empStatus.color,
          shape: BoxShape.circle,
          border: Border.all(color: white, width: 2),
        ),
      ),
    );
  }

  Widget empColumns() {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Employee Picture', style: textBodiesStyle),
            // sizeBoxWidth(size.width * 0.165),
            Text('Employee Name', style: textBodiesStyle),
            // sizeBoxWidth(size.width * 0.165),
            Text('Employee Phone', style: textBodiesStyle),
            // sizeBoxWidth(size.width * 0.165),
            Text('Employee Department', style: textBodiesStyle),
            Text('Employee Status', style: textBodiesStyle),
          ],
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: white),
          ),
          child: CircleAvatar(
            radius: 20,
            // backgroundColor: invisible,
            backgroundImage: MemoryImage(bytes),
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

class UpdateButton extends StatefulWidget {
  final VoidCallback callback;
  final double width, height;
  final String text;

  const UpdateButton({
    super.key,
    required this.callback,
    required this.height,
    required this.width,
    required this.text,
  });

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  bool passMouse = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => passMouse = true),
      onExit: (event) => setState(() => passMouse = false),
      child: InkWell(
        splashColor: invisible,
        onTap: widget.callback,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: passMouse ? green : white, width: 2),
          ),
          child: Center(child: Text(widget.text, style: textBodiesStyle)),
        ),
      ),
    );
  }
}

class EditUserDataTextFieldTemplate extends StatelessWidget {
  const EditUserDataTextFieldTemplate({
    super.key,

    required this.text,
    required this.controller,
    required this.icon,
  });
  final String text;
  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.020,
        vertical: size.height * 0.01,
      ),
      width: size.width * 0.11,
      child: TextFormField(
        controller: controller,
        style: textBodiesStyle,
        decoration: InputDecoration(
          labelText: text,
          // label: Text(text),
          labelStyle: GoogleFonts.aleo(
            color: white,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(icon, color: white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: greenColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: redColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}

class EmpButtonActions extends StatefulWidget {
  final VoidCallback onTap;
  final Color color;
  final IconData icon;

  const EmpButtonActions({
    super.key,
    required this.onTap,
    required this.color,
    required this.icon,
  });

  @override
  State<EmpButtonActions> createState() => _EmpButtonActionsState();
}

class _EmpButtonActionsState extends State<EmpButtonActions> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.005),
        child: Icon(widget.icon, color: widget.color),
      ),
    );
  }
}
