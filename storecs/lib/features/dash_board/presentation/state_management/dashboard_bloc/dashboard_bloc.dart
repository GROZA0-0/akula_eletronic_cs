import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_event.dart';
import 'package:storecs/features/dash_board/presentation/state_management/dashboard_bloc/dashboard_bloc_state.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_category_dashboard_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_employee_info_dash_board_controller.dart';
import 'package:storecs/features/dash_board/presentation/state_management/fetch_reviews_info_dash_board_controller.dart';

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  final FetchEmployeeInfoDashBoardController boardController;
  final String id;
  DashboardBloc(this.boardController, this.id)
    : super(DashboardBlocStateLoading()) {
    on<DashboardBlocEventLoading>((event, emit) async {
      emit(DashboardBlocStateLoading());
      try {
        final getEmpInfo = await boardController.getEmployeeInfo(id);

        emit(DashboardBlocStateLoaded(enitities: getEmpInfo));
      } catch (e) {
        print("any errors into dashboard bloc ${e.toString()}");
        emit((DashboardBlocStateError(err: e.toString())));
      }
    });
    on<DashboardBlocEventChangeStatus>((event, emit) async {
      if (state is DashboardBlocStateLoaded) {
        try {
          final updateStatus = await boardController.changeUserStatus(
            event.id,
            event.status,
          );
          emit(DashboardBlocStateLoaded(enitities: updateStatus));
        } catch (e) {
          print("Error updating status in Bloc: $e");
        }
      }
    });
  }
}

class ReviewDashboardBloc
    extends Bloc<DashboardBlocEvent, ReviewDashboardBlocState> {
  final FetchReviewsInfoDashBoardController reviewBoardController;
  ReviewDashboardBloc(this.reviewBoardController)
    : super(ReviewDashboardBlocStateLoading()) {
    on<DashboardBlocEventLoading>((event, emit) async {
      emit(ReviewDashboardBlocStateLoading());
      try {
        final getReview = await reviewBoardController.getReviews();
        emit(ReviewDashboardBlocStateLoaded(entities: getReview));
      } catch (e) {
        print("any errors into dashboard bloc ${e.toString()}");
        emit((ReviewDashboardBlocStateError(err: e.toString())));
      }
    });
  }
}

class CategoryDashboardBloc
    extends
        Bloc<CategoryChartDashboardBlocEvent, CategoryChartDashboardBlocState> {
  final FetchCategoryDashboardController categoryController;
  CategoryDashboardBloc(this.categoryController)
    : super(CategoryChartDashboardBlocStateLoading()) {
    on<CategoryChartDashboardBlocEventLoading>((event, emit) async {
      emit(CategoryChartDashboardBlocStateLoading());
      try {
        final getChart = await categoryController.fetchChartDashboard();
        emit(CategoryChartDashboardBlocStateLoaded(entities: getChart));
      } catch (e) {
        emit(CategoryChartDashboardBlocStateError(err: e.toString()));
      }
    });
  }
}
