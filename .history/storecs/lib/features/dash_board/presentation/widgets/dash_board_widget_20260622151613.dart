import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/Styles/Colors.dart';
import 'package:storecs/Core/Styles/Strings.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:storecs/Core/Styles/themes.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_up_page.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_event.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_state.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/pos_page/presentation/page/pos_page.dart';
import 'package:storecs/features/staff_list/presentation/page/staff_list.dart';

class DashboardWidgets extends StatefulWidget {
  const DashboardWidgets({super.key});

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  @override
  Widget build(BuildContext context) {
    int touchedIndex = -1;
    final id = FirebaseAuth.instance.currentUser!.uid;
    final List<Map<String, dynamic>> salesData = [
      {'label': 'iPhone', 'value': 40.0, 'color': Color(0xFF6C63FF)},
      {'label': 'Samsung', 'value': 25.0, 'color': Color(0xFF43E97B)},
      {'label': 'Xiaomi', 'value': 20.0, 'color': Color(0xFFFA709A)},
      {'label': 'Huawei', 'value': 10.0, 'color': Color(0xFF4FACFE)},
      {'label': 'Others', 'value': 5.0, 'color': Color(0xFFFFC107)},
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: Text(Dashboard, style: textAppBar),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: size.width * 0.0011,
            ),

            width: size.width / 6,
            height: size.width * 0.2,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => DashboardBloc(
                    Get.find<FetchEmployeeInfoDashBoardController>(),
                    id,
                  )..add(DashboardBlocEventLoading()),
                ),
              ],
              child: BlocBuilder<DashboardBloc, DashboardBlocState>(
                builder: (context, empState) {
                  if (empState is DashboardBlocStateLoading) {
                    return const CircleAvatar(
                      backgroundColor: grey,
                      radius: 18,
                      child: Icon(color: white, Iconsax.user),
                    );
                  } else if (empState is DashboardBlocStateError) {
                    return Container(
                      margin: EdgeInsets.only(right: size.width * 0.03),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.redAccent,
                        child: Icon(
                          Icons.error_outline,
                          color: white,
                          size: 16,
                        ),
                      ),
                    );
                  } else if (empState is DashboardBlocStateLoaded) {
                    final emp = empState.enitities;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(emp.name, style: textBodiesStyle),
                        buildProfileImage(emp.userPic),
                      ],
                    );
                  }
                  return const CircleAvatar(
                    backgroundColor: grey,
                    radius: 18,
                    child: Icon(color: white, Iconsax.user),
                  );
                },
              ),
            ),
          ),
        ],
        leading: DrawerIconAnimation(),
      ),
      drawer: AppDrawer(id: id),
      body: SafeArea(
        child: Container(
          margin: screenSize,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.030,
                    horizontal: size.width * 0.008,
                  ),
                  child: Column(
                    children: [
                      RowOfReviewsSection(),
                      chartAndMostItemSold(touchedIndex, salesData),
                      quickActionsSectionBloc(id),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget quickActionsSectionBloc(String id) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DashboardBloc(
            Get.find<FetchEmployeeInfoDashBoardController>(),
            id,
          )..add(DashboardBlocEventLoading()),
        ),
      ],
      child: BlocBuilder<DashboardBloc, DashboardBlocState>(
        builder: (context, empState) {
          if (empState is DashboardBlocStateLoaded) {
            return QuickActionsSection(employee: empState.enitities);
          }
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(color: white),
          );
        },
      ),
    );
  }

  Widget chartAndMostItemSold(
    int touchedIndex,
    List<Map<String, dynamic>> salesData,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  height: size.height / 2,
                  width: constraints.maxWidth * 0.30,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      centerSpaceRadius: 50,
                      sectionsSpace: 3,
                      sections: salesData.asMap().entries.map((entry) {
                        final index = entry.key;
                        final data = entry.value;
                        final isTouched = index == touchedIndex;

                        return PieChartSectionData(
                          radius: isTouched ? 70 : 55,

                          value: data['value'],
                          color: data['color'],

                          title: '${data['value'].toInt()}%',
                          titleStyle: TextStyle(
                            fontSize: isTouched ? 16 : 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),

                          badgeWidget: isTouched
                              ? Icon(
                                  Icons.phone_android,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                          badgePositionPercentageOffset: 1.2,
                        );
                      }).toList(),
                    ),
                  ),
                ),
                // sizeBoxWidth(size.width / 180),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: salesData.asMap().entries.map((entry) {
                    final index = entry.key;
                    final data = entry.value;
                    final isTouched = index == touchedIndex;

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          // Color dot
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            width: isTouched ? 14 : 10,
                            height: isTouched ? 14 : 10,
                            decoration: BoxDecoration(
                              color: data['color'],
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            '${data['label']}  ${data['value'].toInt()}%',
                            style: TextStyle(
                              color: isTouched ? Colors.white : Colors.white60,
                              fontSize: 20,
                              fontWeight: isTouched
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            width: size.width * 0.30,
            height: size.height * 0.50,
            // margin: EdgeInsets.only(right: size.width * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: white),
            ),
            child: Text('Will be a list of yesterday report'),
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage(String base64Image) {
    if (base64Image.isEmpty) {
      return GestureDetector(
        onTap: () =>
            print(fetchEmployeeInfoDashBoardController.blocEntities.name),
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
        return Container(
          margin: EdgeInsets.only(right: size.width * 0.03),
          child: const CircleAvatar(
            radius: 20,
            backgroundColor: Colors.redAccent,
            child: Icon(Icons.error_outline, color: white, size: 16),
          ),
        );
      }
    }
  }
}

class RowOfReviewsSection extends StatelessWidget {
  const RowOfReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // color: green,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: white),
          ),
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Allows card to wrap its content tightly
            children: [
              Text(Revenues, style: textBodiesStyle),
              Text(NumberOfRevenues, style: textBodiesStyle),
            ],
          ),
        ),
        sizeBoxWidth(size.width * 0.009),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // color: gold,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 1, color: white),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Orders, style: textBodiesStyle),
              Text(NumberOfOrders, style: textBodiesStyle),
            ],
          ),
        ),
        sizeBoxWidth(size.width * 0.009),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            // color: pink,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: white,
            ), // Fixed: Changed from BoxBorder.all
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(Visitors, style: textBodiesStyle),
              Text(NumberOfVisitors, style: textBodiesStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final EmployeeInfoEntities employee;
  const QuickActionsSection({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final bool isSupervisor = employee.level == 'Supervisor';
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: size.width * 0.05),
          width: size.width / 1.2,
          child: Text(QuickActionsText, style: textBodiesStyle),
        ),
        Divider(height: 2, color: white),
        sizeBoxHeight(size.height * 0.02),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            isSupervisor
                ? QuickActionsButton(
                    mainPageWidget: () {},
                    size: size,
                    text: 'Staff List Page',
                    iconn: Iconsax.user,
                  )
                : QuickActionsButton(
                    mainPageWidget: () {},
                    size: size,
                    text: 'POS Page',
                    iconn: Iconsax.card_pos,
                  ),
            sizeBoxWidth(size.width * 0.01),
            isSupervisor
                ? QuickActionsButton(
                    mainPageWidget: () => Get.to(
                      () => GradientBackground(child: SignUpPage()),
                      transition: naviStyleToAnotherPage,
                    ),
                    size: size,
                    text: 'Add/Edit Staff',
                    iconn: Icons.add,
                  )
                : QuickActionsButton(
                    mainPageWidget: () {},
                    size: size,
                    text: 'order List Page',
                    iconn: Icons.list,
                  ),
            sizeBoxWidth(size.width * 0.01),
            QuickActionsButton(
              mainPageWidget: () {},
              size: size,
              text: 'Sales Report',
              iconn: Iconsax.export,
            ),
            sizeBoxWidth(size.width * 0.01),
            isSupervisor
                ? QuickActionsButton(
                    mainPageWidget: () {},
                    size: size,
                    text: 'Profit/Loss Page',
                    iconn: Icons.arrow_outward,
                  )
                : QuickActionsButton(
                    mainPageWidget: () {},
                    size: size,
                    text: 'Returns & Refunds',
                    iconn: Icons.compare_arrows,
                  ),
          ],
        ),
        sizeBoxHeight(size.height * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DoYouHaveAnyIssueOrSuggestionsText, style: textBodiesStyle),
            sizeBoxWidth(size.width * 0.0040),
            GestureDetector(
              child: Text(ClickHereText, style: TextStyle(color: grey)),
            ),
          ],
        ),
      ],
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String id;
  const AppDrawer({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: white,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => DashboardBloc(
                Get.find<FetchEmployeeInfoDashBoardController>(),
                id,
              )..add(DashboardBlocEventLoading()),
            ),
          ],
          child: BlocBuilder<DashboardBloc, DashboardBlocState>(
            builder: (context, state) {
              if (state is DashboardBlocStateLoading) {
                return loadingStateBlocMethod(size);
              } else if (state is DashboardBlocStateLoaded) {
                final cashierAccess = state.enitities.level == 'Cashier';
                final baristaAccess = state.enitities.level == 'Barista';
                // final SupervisorAccess = state.enitities.level == 'Supervisor';
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        checkoutExpansionTile(),
                        productsExpansionTile(),
                        ordersAndTransactions(),
                        cashierAccess || baristaAccess
                            ? Container()
                            : employees(),
                        reports(),
                        cashierAccess || baristaAccess
                            ? Container()
                            : settings(),
                      ],
                    ),
                    signOutButton(),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Container signOutButton() {
    return Container(
      color: redColor,
      width: size.width * 0.06,
      margin: EdgeInsets.only(right: size.width * 0.15),
      child: InkWell(
        onTap: () => signOutController.signOutTrigger(),
        child: Row(
          children: [
            Icon(Iconsax.logout5, color: redColor),
            sizeBoxWidth(size.width * 0.005),
            Text(SignOut, style: textBodiesStyle2),
          ],
        ),
      ),
    );
  }

  Widget settings() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Settings'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Settings Page",
              iconn: Iconsax.paperclip,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "User Profile Page",
              iconn: Icons.arrow_outward,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Backup/Restore ",
              iconn: Iconsax.export,
            ),
          ],
        ),
      ],
    );
  }

  Widget reports() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Reports'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Sales Report",
              iconn: Iconsax.paperclip,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Profit/Loss Page",
              iconn: Icons.arrow_outward,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Export Page",
              iconn: Iconsax.export,
            ),
          ],
        ),
      ],
    );
  }

  Widget employees() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Employees'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () => Get.to(
                () => GradientBackground(child: StaffListPage()),
                transition: naviStyleToAnotherPage,
              ),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Staff List Page",
                iconn: Iconsax.user,
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () => Get.to(
                () => GradientBackground(child: SignUpPage()),
                transition: naviStyleToAnotherPage,
              ),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Add/Edit Staff",
                iconn: Icons.add,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget ordersAndTransactions() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Orders & Transactions'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Orders List Page",
              iconn: Icons.line_style_rounded,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Returns / Refunds",
              iconn: Icons.compare_arrows,
            ),
          ],
        ),
      ],
    );
  }

  Widget productsExpansionTile() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Products / Inventory'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Products List Page",
              iconn: Icons.line_style_rounded,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Categories Page",
              iconn: Iconsax.category,
            ),
          ],
        ),
      ],
    );
  }

  Widget checkoutExpansionTile() {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Sales / Checkout'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () => Get.to(
                () => const GradientBackground(child: PosPage()),
                transition: naviStyleToAnotherPage,
              ),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "POS Page",
                iconn: Iconsax.card_pos,
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Card Page",
              iconn: Iconsax.card,
            ),

            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Payment Page",
              iconn: Icons.payment,
            ),

            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Receipt Page",
              iconn: Iconsax.receipt,
            ),
          ],
        ),
      ],
    );
  }
}

class ButtonsMenuDrawer extends StatelessWidget {
  final Widget mainPageWidget;
  final Size size;
  final String text;
  final IconData iconn;
  const ButtonsMenuDrawer({
    super.key,
    required this.mainPageWidget,
    required this.size,
    required this.text,
    required this.iconn,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mainPageWidget,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconn, color: black),
          sizeBoxWidth(size.width * 0.009),
          textDrawerStyle(text),
        ],
      ),
    );
  }
}

class QuickActionsButton extends StatefulWidget {
  final VoidCallback mainPageWidget;
  final Size size;
  final String text;
  final IconData iconn;
  const QuickActionsButton({
    super.key,
    required this.mainPageWidget,
    required this.size,
    required this.text,
    required this.iconn,
  });

  @override
  State<QuickActionsButton> createState() => _QuickActionsButton();
}

class _QuickActionsButton extends State<QuickActionsButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: MouseRegion(
        onExit: (event) => setState(() => isHovered = false),
        onEnter: (event) => setState(() => isHovered = true),
        child: GestureDetector(
          onTap: widget.mainPageWidget,
          child: Container(
            height: size.height / 12,
            // width: size.width / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isHovered ? green : white),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(widget.iconn, color: white),
                  Text(widget.text, style: textBodiesStyle),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
