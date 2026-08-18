import 'package:equatable/equatable.dart';
import 'package:storecs/features/profile_page/domain/entities/profile_entities.dart';

abstract class ProfileBlocState extends Equatable {}

class ProfileBlocStateLoading extends ProfileBlocState {
  @override
  List<Object?> get props => [];
}

class ProfileBlocStateLoaded extends ProfileBlocState {
  final ProfileEntities entities;
  ProfileBlocStateLoaded({required this.entities});

  @override
  List<Object?> get props => [entities];
}

class ProfileBlocStateError extends ProfileBlocState {
  final String err;
  ProfileBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
