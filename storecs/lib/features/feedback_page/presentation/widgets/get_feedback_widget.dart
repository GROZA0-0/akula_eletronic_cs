import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storecs/Core/Styles/Colors.dart';
import 'package:storecs/Core/styles/alerts.dart';
import 'package:storecs/Core/styles/animations.dart';
import 'package:storecs/Core/styles/sizes.dart';
import 'package:storecs/Core/styles/text_styles.dart';
import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_bloc/get_feedback_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_bloc/get_feedback_bloc_event.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_bloc/get_feedback_bloc_state.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_controller.dart';
import 'package:storecs/main.dart';

class GetFeedbackWidget extends StatefulWidget {
  const GetFeedbackWidget({super.key});

  @override
  State<GetFeedbackWidget> createState() => _GetFeedbackWidgetState();
}

class _GetFeedbackWidgetState extends State<GetFeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    final alerts = Alerts(messengerKey);
    final sl = GetIt.instance;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: invisible,
        iconTheme: IconThemeData(color: white),
        title: FadeInLeft(child: Text('Feedback List ', style: textAppBar)),
      ),
      body: SafeArea(
        child: Container(
          margin: screenSize,
          width: double.infinity,
          // height: size.height / 1.1,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FadeInUp(
              child: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) =>
                        GetFeedbackBloc(sl<GetFeedbackController>())
                          ..add(GetFeedbackBlocEventLoading()),
                  ),
                ],
                child: BlocBuilder<GetFeedbackBloc, GetFeedbackBlocState>(
                  builder: (context, state) {
                    if (state is GetFeedbackBlocStateLoading) {
                      return loadingStateBlocMethod(size);
                    } else if (state is GetFeedbackBlocStateError) {
                      return alerts.ifErrors(state.err.toString());
                    } else if (state is GetFeedbackBlocStateLoaded) {
                      List<GetFeedbackEnitities> list = List.from(
                        state.entities,
                      );
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        itemBuilder: (context, innerIndex) {
                          final task = list[innerIndex];

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
                            height: size.height / 1.2,
                            width: size.width / 1.3,
                            child: Column(
                              children: [
                                Text(
                                  'Order ID: ${task.id}',
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
                                        'By: ${task.empEmail}',
                                        style: GoogleFonts.aleo(
                                          fontSize: 21,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: Text(
                                        'The issue: ${task.issue}',
                                        style: GoogleFonts.aleo(
                                          fontSize: 20,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: Text(
                                        'The Severity: ${task.severity}',
                                        style: GoogleFonts.aleo(
                                          fontSize: 20,
                                          color: white,
                                        ),
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
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: size.width * 0.005,
                                        top: size.height * 0.005,
                                      ),
                                      child: Text(
                                        task.note!,
                                        style: textBodiesStyle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
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
