import 'package:equatable/equatable.dart';
import 'package:storecs/features/feedback_page/domain/enitities/feedback_enitities.dart';

abstract class GetFeedbackBlocState extends Equatable {}

class GetFeedbackBlocStateLoading extends GetFeedbackBlocState {
  @override
  List<Object?> get props => [];
}

class GetFeedbackBlocStateLoaded extends GetFeedbackBlocState {
  final List<GetFeedbackEnitities> entities;
  GetFeedbackBlocStateLoaded({required this.entities});
  @override
  List<Object?> get props => [entities];
}

class GetFeedbackBlocStateError extends GetFeedbackBlocState {
  final String err;
  GetFeedbackBlocStateError({required this.err});
  @override
  List<Object?> get props => [err];
}
