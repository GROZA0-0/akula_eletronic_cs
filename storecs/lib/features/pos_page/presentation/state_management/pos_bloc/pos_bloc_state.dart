import 'package:equatable/equatable.dart';
import 'package:storecs/features/pos_page/domain/enitities/pos_entities.dart';

abstract class PosBlocState extends Equatable {}

class PosBlocStateLoading extends PosBlocState {
  @override
  List<Object?> get props => [];
}

class PosBlocStateLoaded extends PosBlocState {
  final List<PosEntities> entities;
  PosBlocStateLoaded({required this.entities});
  @override
  List<Object?> get props => [entities];
}

class PosBlocStateEmpty extends PosBlocState {
  @override
  List<Object?> get props => [];
}

class PosBlocStateError extends PosBlocState {
  final String err;
  PosBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
