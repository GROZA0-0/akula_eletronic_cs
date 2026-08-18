import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_bloc/profile_bloc_event.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_bloc/profile_bloc_state.dart';
import 'package:storecs/features/profile_page/presentation/state_management/profile_controller.dart';

class ProfileBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  final ProfileController controller;
  ProfileBloc(this.controller) : super(ProfileBlocStateLoading()) {
    on<ProfileBlocEventLoading>((event, emit) async {
      emit(ProfileBlocStateLoading());
      try {
        final id = FirebaseAuth.instance.currentUser!.uid;
        final entity = await controller.getUserProfileInfo(id);
        emit(ProfileBlocStateLoaded(entities: entity));
      } catch (e) {
        emit(ProfileBlocStateError(err: e.toString()));
      }
    });
  }
}
