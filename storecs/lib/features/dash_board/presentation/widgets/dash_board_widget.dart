import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:storecs/Core/Styles/Colors.dart';
import 'package:storecs/Core/Styles/Strings.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:storecs/Core/config/account_status.dart';
import 'package:storecs/Core/config/call_controller.dart';
import 'package:storecs/Core/config/permissions.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/Features/auth/presentation/pages/sign_up_page.dart';
import 'package:storecs/features/dash_board/domain/entities/employee_info_entities.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_event.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_state.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_category_dashboard_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_reviews_info_dash_board_controller.dart';
import 'package:storecs/features/feedback_page/presentation/pages/get_feedback_page.dart';
import 'package:storecs/features/issues_or_suggestions/presentation/page/issues_or_suggestions_page.dart';
import 'package:storecs/features/order_purchased_history/presentation/pages/order_purchased_history.dart';
import 'package:storecs/features/pos_page/presentation/page/pos_page.dart';
import 'package:storecs/features/product_list/presentation/pages/product_list.dart';
import 'package:storecs/features/report_page/presentation/page/report_page.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_event.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_bloc/report_bloc_state.dart';
import 'package:storecs/features/report_page/presentation/state_management/report_controller.dart';
import 'package:storecs/features/returns&refunds/presentation/page/returns_and_refunds_page.dart';
import 'package:storecs/features/settings_page/presentation/page/settings_page.dart';
import 'package:storecs/features/staff_list/presentation/page/staff_list.dart';

class DashboardWidgets extends StatefulWidget {
  const DashboardWidgets({super.key});

  @override
  State<DashboardWidgets> createState() => _DashboardWidgetsState();
}

class _DashboardWidgetsState extends State<DashboardWidgets> {
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        title: FadeInLeft(child: Text(Dashboard, style: textAppBar)),
        actions: [appbarDashboardBloc(id)],
        leading: Builder(
          builder: (context) {
            return FadeInLeft(
              child: DrawerIconAnimation(
                iconData: Iconsax.menu,
                voidCallback: () => Scaffold.of(context).openDrawer(),
              ),
            );
          },
        ),
      ),
      drawer: AppDrawer(id: id),
      body: SafeArea(
        child: FadeInUp(
          child: Container(
            margin: screenSize,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: white, width: 3),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.030,
                  horizontal: size.width * 0.008,
                ),
                child: Column(
                  children: [
                    RowOfReviewsSection(id: id),
                    ChartSectionWidget(),
                    quickActionsSectionBloc(id),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget appbarDashboardBloc(String id) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.03,
        vertical: size.width * 0.0011,
      ),

      width: size.width / 4,
      height: size.width * 0.2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                DashboardBloc(sl<FetchEmployeeInfoDashBoardController>(), id)
                  ..add(DashboardBlocEventLoading()),
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
                  backgroundColor: redColor,
                  child: Icon(Icons.error_outline, color: white, size: 16),
                ),
              );
            } else if (empState is DashboardBlocStateLoaded) {
              final emp = empState.enitities;
              return FadeInRight(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      userStatusCircularAvatar(emp.id),
                      userAccountName(emp),
                      buildProfileImage(emp.userPic),
                    ],
                  ),
                ),
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
    );
  }

  Text userAccountName(EmployeeInfoEntities emp) =>
      Text(emp.name, style: textBodiesStyle);

  BlocBuilder<DashboardBloc, DashboardBlocState> userStatusCircularAvatar(
    String id,
  ) {
    return BlocBuilder<DashboardBloc, DashboardBlocState>(
      builder: (context, state) {
        if (state is DashboardBlocStateLoading) {
          return Container(
            width: size.width * 0.02,
            height: size.height * 0.02,
            decoration: BoxDecoration(
              color: colorGrey,
              shape: BoxShape.circle,
              border: Border.all(color: white, width: 2),
            ),
          );
        } else if (state is DashboardBlocStateLoading) {
          return Container(
            width: size.width * 0.02,
            height: size.height * 0.02,
            decoration: BoxDecoration(
              color: deepViolet,
              shape: BoxShape.circle,
              border: Border.all(color: white, width: 2),
            ),
          );
        } else if (state is DashboardBlocStateLoaded) {
          final currentStatus = state.enitities.status;
          return PopupMenuButton<UserAccountStatus>(
            onSelected: (UserAccountStatus status) {
              /* update the status color instantly */
              context.read<DashboardBloc>().add(
                DashboardBlocEventChangeStatus(id: id, status: status),
              );
            },
            itemBuilder: (context) => circleUserStatus().toList(),
            child: Container(
              width: size.width * 0.023,
              height: size.height * 0.023,
              decoration: BoxDecoration(
                color: currentStatus.color,
                shape: BoxShape.circle,
                border: Border.all(color: white, width: 2),
              ),
            ),
          );
        }
        return Container(
          width: size.width * 0.02,
          height: size.height * 0.02,
          decoration: BoxDecoration(
            color: deepViolet,
            shape: BoxShape.circle,
            border: Border.all(color: white, width: 2),
          ),
        );
      },
    );
  }

  Iterable<PopupMenuItem<UserAccountStatus>> circleUserStatus() {
    return UserAccountStatus.values.map((usrStatus) {
      return PopupMenuItem(
        value: usrStatus,
        child: Row(
          children: [
            Container(
              width: size.width * 0.02,
              height: size.height * 0.02,
              decoration: BoxDecoration(
                color: usrStatus.color,
                shape: BoxShape.circle,
                border: Border.all(color: deepViolet, width: 2),
              ),
            ),
            Text(
              usrStatus.label,
              style: GoogleFonts.aleo(
                color: deepViolet,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget quickActionsSectionBloc(String id) {
    return MultiBlocProvider(
      key: ValueKey(id),
      providers: [
        BlocProvider(
          create: (context) =>
              DashboardBloc(sl<FetchEmployeeInfoDashBoardController>(), id)
                ..add(DashboardBlocEventLoading()),
        ),
      ],
      child: BlocBuilder<DashboardBloc, DashboardBlocState>(
        builder: (context, empState) {
          if (empState is DashboardBlocStateLoaded) {
            return QuickActionsSection(employee: empState.enitities);
          }
          return Container();
        },
      ),
    );
  }

  Widget buildProfileImage(String base64Image) {
    if (base64Image.isEmpty) {
      return const CircleAvatar(
        backgroundColor: grey,
        radius: 20,
        child: Icon(color: white, Iconsax.user),
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
          child: CircleAvatar(radius: 20, backgroundImage: MemoryImage(bytes)),
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

class ChartSectionWidget extends StatelessWidget {
  const ChartSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CategoryDashboardBloc(
            Get.find<FetchCategoryDashboardController>(),
          )..add(CategoryChartDashboardBlocEventLoading()),
        ),
      ],
      child:
          BlocBuilder<CategoryDashboardBloc, CategoryChartDashboardBlocState>(
            builder: (context, state) {
              if (state is CategoryChartDashboardBlocStateLoading) {
                return loadingStateBodies();
              } else if (state is CategoryChartDashboardBlocStateError) {
                return Text(state.err, style: textBodiesStyle2);
              } else if (state is CategoryChartDashboardBlocStateLoaded) {
                final mappedSalesData =
                    FetchCategoryDashboardController.mapCategoryAvgToSalesData(
                      state.entities,
                    );
                if (mappedSalesData.isEmpty) {
                  return Center(
                    child: Text(
                      "No sales data available per category",
                      style: textBodiesStyle2,
                    ),
                  );
                }
                return InteractivePieChartSection(salesData: mappedSalesData);
              }
              return const SizedBox.shrink();
            },
          ),
    );
  }
}

class InteractivePieChartSection extends StatefulWidget {
  final List<Map<String, dynamic>> salesData;

  const InteractivePieChartSection({super.key, required this.salesData});

  @override
  State<InteractivePieChartSection> createState() =>
      _InteractivePieChartSectionState();
}

class _InteractivePieChartSectionState
    extends State<InteractivePieChartSection> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [chartPercentage(constraints), listOfChartsReviews()],
            ),
          ),
          reportSection(),
        ],
      ),
    );
  }

  Container reportSection() {
    final userLevel = fetchEmployeeInfoDashBoardController.blocEntities.level;
    return Container(
      width: size.width * 0.30,
      height: size.height * 0.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: white),
      ),
      child: SingleChildScrollView(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ReportBloc(controller: Get.find<ReportController>())..add(
                    ReportBlocEventLoading(
                      level: userLevel.isNotEmpty ? userLevel : 'Supervisor',
                    ),
                  ),
            ),
          ],
          child: BlocBuilder<ReportBloc, ReportBlocState>(
            builder: (context, state) {
              if (state is ReportBlocStateLoading) {
                return reportSectionLoading();
              } else if (state is ReportBlocStateError) {
                return SizedBox(
                  height: size.height / 2.01,
                  child: Center(
                    child: Text(
                      "Somthing went wrong!",
                      style: textBodiesStyle2,
                    ),
                  ),
                );
              } else if (state is ReportBlocStateLoaded) {
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.002,
                    vertical: size.height * 0.002,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.entities.title,
                        style: GoogleFonts.aleo(
                          fontSize: 24,
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        state.entities.subTitle,
                        style: GoogleFonts.aleo(
                          color: white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget chartPercentage(BoxConstraints constraints) {
    return SizedBox(
      height: size.height / 2,
      width: constraints.maxWidth * 0.30,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                if (touchedIndex != -1) {
                  setState(() {
                    touchedIndex = -1;
                  });
                }
                return;
              }

              final newIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
              if (newIndex != touchedIndex) {
                setState(() {
                  touchedIndex = newIndex;
                });
              }
            },
          ),
          centerSpaceRadius: 50,
          sectionsSpace: 3,
          sections: widget.salesData.asMap().entries.map((entry) {
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
                color: white,
              ),

              badgeWidget: isTouched
                  ? Icon(Icons.phone_android, color: white, size: 16)
                  : null,
              badgePositionPercentageOffset: 1.2,
            );
          }).toList(),
        ),
      ),
    );
  }

  Column listOfChartsReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.salesData.asMap().entries.map((entry) {
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
              sizeBoxWidth(size.width * 0.008),
              Text(
                '${data['label']}  ${data['value'].toInt()}%',
                style: TextStyle(
                  color: isTouched ? white : lightGrey,
                  fontSize: 20,
                  fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class RowOfReviewsSection extends StatelessWidget {
  final String id;
  const RowOfReviewsSection({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReviewDashboardBloc(
            Get.find<FetchReviewsInfoDashBoardController>(),
          )..add(DashboardBlocEventLoading()),
        ),
      ],
      child: BlocBuilder<ReviewDashboardBloc, ReviewDashboardBlocState>(
        builder: (context, state) {
          if (state is ReviewDashboardBlocStateError) {
            return ReviewsSectionInfo(title: '', subTitle: 'Error');
          } else if (state is ReviewDashboardBlocStateLoaded) {
            final totalRev = state.entities
                .fold<double>(
                  0.0,
                  (previousValue, element) =>
                      previousValue + element.totalPrice,
                )
                .round()
                .toString();
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(Revenues, style: textBodiesStyle),
                      Text('$totalRev JOD', style: textBodiesStyle),
                    ],
                  ),
                ),
                sizeBoxWidth(size.width * 0.009),
                ReviewsSectionInfo(
                  title: Orders,
                  subTitle: state.entities.length.toString(),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

class ReviewsSectionInfo extends StatelessWidget {
  final String title;
  final String subTitle;
  const ReviewsSectionInfo({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(title, style: textBodiesStyle),
          Text(subTitle, style: textBodiesStyle),
        ],
      ),
    );
  }
}

class QuickActionsSection extends StatelessWidget {
  final EmployeeInfoEntities employee;
  const QuickActionsSection({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    final permissions = Permissions(state: employee);
    final hasAccess = permissions.empPagesAccCondition;
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
            QuickActionsButton(
              mainPageWidget: () => hasAccess
                  ? Navigator.push(context, naviToAnotherPage(PosPage()))
                  : Navigator.push(context, naviToAnotherPage(StaffListPage())),
              size: size,
              text: hasAccess ? 'POS Page' : 'Staff List Page',
              iconn: hasAccess ? Iconsax.card_pos : Iconsax.user,
            ),

            sizeBoxWidth(size.width * 0.01),

            QuickActionsButton(
              mainPageWidget: () => hasAccess
                  ? Navigator.push(
                      context,
                      naviToAnotherPage(ProductListPage()),
                    )
                  : Navigator.push(context, naviToAnotherPage(SignUpPage())),
              size: size,
              text: hasAccess ? 'order List Page' : 'Add/Edit Staff',
              iconn: hasAccess ? Icons.list : Icons.add,
            ),
            sizeBoxWidth(size.width * 0.01),

            QuickActionsButton(
              mainPageWidget: () => hasAccess
                  ? () {}
                  : Navigator.push(context, naviToAnotherPage(ReportPage())),
              size: size,
              text: hasAccess ? 'Card Page' : 'Sales Report',
              iconn: Iconsax.export,
            ),
            sizeBoxWidth(size.width * 0.01),

            QuickActionsButton(
              mainPageWidget: () => hasAccess
                  ? () {}
                  : Navigator.push(
                      context,
                      naviToAnotherPage(ReturnsAndRefundsPage()),
                    ),
              size: size,
              text: hasAccess ? 'Profit/Loss Page' : 'Returns & Refunds',
              iconn: hasAccess ? Icons.arrow_outward : Icons.compare_arrows,
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
            InkWell(
              onTap: () => Navigator.push(
                context,
                feedbacktNaviRoute(IssuesOrSuggestionsPage()),
              ),
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
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    drawerList(state, context),
                    Divider(),
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

  Widget drawerList(DashboardBlocStateLoaded state, BuildContext context) {
    final permissions = Permissions(state: state.enitities);
    final hasAccessEmpPages = permissions.empPagesAccCondition;
    final hasAccessPAI = permissions.productsAndInventoryCondition;
    final hasAccessReports = permissions.reportsCondition;
    final hasAccessSettings = permissions.settingsPageAccCondition;
    final hasAccessOrderActions = permissions.orderActionsAccCondition;
    return SizedBox(
      width: size.width / 1.2,
      height: size.height / 1.09,
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Text(
                "Akula",
                style: GoogleFonts.pixelifySans(
                  color: deepViolet,
                  fontSize: 27,
                  fontWeight: FontWeight.w400,
                ),
              ),
              checkoutExpansionTile(context),
              hasAccessPAI ? Container() : productsExpansionTile(context),
              hasAccessOrderActions
                  ? Container()
                  : ordersAndTransactions(context),
              hasAccessEmpPages ? Container() : employees(context),
              hasAccessReports ? Container() : reports(state, context),
              hasAccessSettings ? Container() : settings(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget signOutButton() {
    return Container(
      width: size.width * 0.07,
      margin: EdgeInsets.only(right: size.width * 0.14),
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

  Widget settings(BuildContext context) {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Settings'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () =>
                  Navigator.push(context, naviToAnotherPage(SettingsPage())),
              /* Get.to(
                () => GradientBackground(child: SettingsPage()),
                transition: naviStyleToAnotherPage,
                preventDuplicates: false,
              ), */
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Settings Page",
                iconn: Iconsax.paperclip,
                color: deepViolet,
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "User Profile Page",
              iconn: Icons.arrow_outward,
              color: deepViolet,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Backup/Restore ",
              iconn: Iconsax.export,
              color: deepViolet,
            ),
          ],
        ),
      ],
    );
  }

  Widget reports(DashboardBlocStateLoaded state, BuildContext context) {
    final permissions = Permissions(state: state.enitities);
    final hasAccessSalesReport = permissions.salesReportCondition;
    final hasAccessFeedback = permissions.getFeedbackCondition;
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Reports'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () =>
                  Navigator.push(context, naviToAnotherPage(ReportPage())),
              child: Column(
                children: [
                  hasAccessSalesReport
                      ? Container()
                      : ButtonsMenuDrawer(
                          mainPageWidget: Text(''),
                          size: size,
                          text: "Sales Report",
                          iconn: Iconsax.ticket,
                          color: deepViolet,
                        ),
                ],
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () =>
                  Navigator.push(context, naviToAnotherPage(GetFeedbackPage())),
              child: Column(
                children: [
                  hasAccessFeedback
                      ? Container()
                      : ButtonsMenuDrawer(
                          mainPageWidget: Text(''),
                          size: size,
                          text: "Feedback Page",
                          iconn: FontAwesomeIcons.readme,
                          color: deepViolet,
                        ),
                ],
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Profit/Loss Page",
              iconn: Icons.arrow_outward,
              color: deepViolet,
            ),
            sizeBoxHeight(size.height * 0.012),
            ButtonsMenuDrawer(
              mainPageWidget: Text(''),
              size: size,
              text: "Export Page",
              iconn: Iconsax.export,
              color: deepViolet,
            ),
          ],
        ),
      ],
    );
  }

  Widget employees(BuildContext context) {
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
              onTap: () =>
                  Navigator.push(context, naviToAnotherPage(StaffListPage())),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Staff List Page",
                iconn: Iconsax.user,
                color: deepViolet,
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () =>
                  Navigator.push(context, naviToAnotherPage(SignUpPage())),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Add/Edit Staff",
                iconn: Icons.add,
                color: deepViolet,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget ordersAndTransactions(BuildContext context) {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Orders & Transactions'),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () => Navigator.push(
                context,
                naviToAnotherPage(OrderPurchasedHistory()),
              ),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Orders Puschased Page",
                iconn: Icons.line_style_rounded,
                color: deepViolet,
              ),
            ),
            sizeBoxHeight(size.height * 0.012),
            InkWell(
              splashColor: deepViolet.withOpacity(0.4),
              onTap: () => Navigator.push(
                context,
                naviToAnotherPage(ReturnsAndRefundsPage()),
              ),
              child: ButtonsMenuDrawer(
                mainPageWidget: Text(''),
                size: size,
                text: "Returns / Refunds",
                iconn: Icons.compare_arrows,
                color: deepViolet,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productsExpansionTile(BuildContext context) {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Products / Inventory'),
      children: [
        InkWell(
          splashColor: deepViolet.withOpacity(0.4),
          onTap: () =>
              Navigator.push(context, naviToAnotherPage(ProductListPage())),
          child: ButtonsMenuDrawer(
            mainPageWidget: Text(''),
            size: size,
            text: "Products List Page",
            iconn: Icons.line_style_rounded,
            color: deepViolet,
          ),
        ),
      ],
    );
  }

  Widget checkoutExpansionTile(BuildContext context) {
    return ExpansionTile(
      splashColor: invisible,
      collapsedIconColor: black,
      collapsedBackgroundColor: white,
      title: textDrawerStyle('Sales / Checkout'),
      children: [
        InkWell(
          splashColor: deepViolet.withOpacity(0.4),
          onTap: () => Navigator.push(context, naviToAnotherPage(PosPage())),
          child: ButtonsMenuDrawer(
            mainPageWidget: Text(''),
            size: size,
            text: "POS Page",
            iconn: Iconsax.card_pos,
            color: deepViolet,
          ),
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
  final Color color;
  const ButtonsMenuDrawer({
    super.key,
    required this.mainPageWidget,
    required this.size,
    required this.text,
    required this.iconn,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mainPageWidget,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconn, color: color),
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
    return Expanded(
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
