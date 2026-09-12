import 'package:equatable/equatable.dart';

abstract class ProfitLossLogsBlocEvent extends Equatable {}

class ProfitLossLogsBlocEventLoading extends ProfitLossLogsBlocEvent {
  @override
  List<Object?> get props => [];
}

class ProfitLossLogsBlocEventError extends ProfitLossLogsBlocEvent {
  final String err;
  ProfitLossLogsBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
