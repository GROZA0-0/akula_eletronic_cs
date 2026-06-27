import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/staff_list/domain/entities/staff_list_entities.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_bloc/staff_list_bloc_event.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_bloc/staff_list_bloc_state.dart';
import 'package:storecs/features/staff_list/presentation/state_management/staff_list_controller.dart';

class StaffListBloc extends Bloc<StaffListBlocEvent, StaffListBlocState> {
  final StaffListController controller;
  StaffListBloc(this.controller) : super(StaffListBlocStateLoading()) {
    on<StaffListBlocEventLoading>((event, emit) async {
      emit(StaffListBlocStateLoading());
      try {
        final List<StaffListEntities> getStaffList = await controller
            .getStaff();
        emit(StaffListBlocStateLoaded(entities: getStaffList));
      } catch (e) {
        print("staff list bloc error ${e.toString()}");
        emit(StaffListBlocStateError(err: e.toString()));
      }
    });
  }
}
