import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_bloc/order_purchased_history_bloc_event.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_bloc/order_purchased_history_bloc_state.dart';
import 'package:storecs/features/order_purchased_history/presentation/state_management/order_purchased_history_controller.dart';

class OrderPurchasedHistoryBloc
    extends
        Bloc<OrderPurchasedHistoryBlocEvent, OrderPurchasedHistoryBlocState> {
  final OrderPurchasedHistoryController controller;
  OrderPurchasedHistoryBloc(this.controller)
    : super(OrderPurchasedHistoryBlocStateLoading()) {
    on<OrderPurchasedHistoryBlocEvent>((event, emit) async {
      emit(OrderPurchasedHistoryBlocStateLoading());
      try {
        await controller.getOrdersSoldHistorical();
        final groupedMap = controller.groupedOrders;
        if (groupedMap.isEmpty) {
          emit(OrderPurchasedHistoryBlocStateEmpty());
        } else {
          emit(OrderPurchasedHistoryBlocStateLoaded(entities: groupedMap));
        }
      } catch (e) {
        emit(OrderPurchasedHistoryBlocStateError(err: e.toString()));
      }
    });
  }
}
