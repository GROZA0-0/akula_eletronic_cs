import 'package:equatable/equatable.dart';

abstract class ProfileBlocEvent extends Equatable {}

class ProfileBlocEventLoading extends ProfileBlocEvent {
  @override
  List<Object?> get props => [];
}

class ProfileBlocEventError extends ProfileBlocEvent {
  final String err;
  ProfileBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
