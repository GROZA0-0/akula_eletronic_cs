import 'package:equatable/equatable.dart';
import 'package:storecs/features/profit_loss_page/domain/entities/profit_loss_entities.dart';

abstract class ProfitLossLogsBlocState extends Equatable {}

class ProfitLossLogsBlocStateLoading extends ProfitLossLogsBlocState {
  @override
  List<Object?> get props => [];
}

class ProfitLossLogsBlocStateLoaded extends ProfitLossLogsBlocState {
  final List<ProfitLossEntities> entities;
  ProfitLossLogsBlocStateLoaded({required this.entities});

  @override
  List<Object?> get props => [entities];
}

class ProfitLossLogsBlocStateError extends ProfitLossLogsBlocState {
  final String err;
  ProfitLossLogsBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
