import 'package:equatable/equatable.dart';

abstract class GetFeedbackBlocEvent extends Equatable {}

class GetFeedbackBlocEventLoading extends GetFeedbackBlocEvent {
  @override
  List<Object?> get props => [];
}

class GetFeedbackBlocError extends GetFeedbackBlocEvent {
  final String err;
  GetFeedbackBlocError({required this.err});

  @override
  List<Object?> get props => [err];
}
