import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_bloc/get_feedback_bloc_event.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_bloc/get_feedback_bloc_state.dart';
import 'package:storecs/features/feedback_page/presentation/state_management/get_feedback_controller.dart';

class GetFeedbackBloc extends Bloc<GetFeedbackBlocEvent, GetFeedbackBlocState> {
  final GetFeedbackController controller;
  GetFeedbackBloc(this.controller) : super(GetFeedbackBlocStateLoading()) {
    on<GetFeedbackBlocEventLoading>((event, emit) async {
      emit(GetFeedbackBlocStateLoading());
      try {
        final List<GetFeedbackEnitities> getFeedbackList = await controller
            .getFeedbacks();
        emit(GetFeedbackBlocStateLoaded(entities: getFeedbackList));
      } catch (e) {
        emit(GetFeedbackBlocStateError(err: e.toString()));
      }
    });
  }
}
