import 'package:equatable/equatable.dart';
import 'package:storecs/features/order_purchased_history/domain/entities/order_purchased_history_entities.dart';

abstract class OrderPurchasedHistoryBlocState extends Equatable {}

class OrderPurchasedHistoryBlocStateLoading
    extends OrderPurchasedHistoryBlocState {
  @override
  List<Object?> get props => [];
}

class OrderPurchasedHistoryBlocStateEmpty
    extends OrderPurchasedHistoryBlocState {
  @override
  List<Object?> get props => [];
}

class OrderPurchasedHistoryBlocStateLoaded
    extends OrderPurchasedHistoryBlocState {
  final Map<String, List<OrderPurchasedHistoryEntities>> entities;
  OrderPurchasedHistoryBlocStateLoaded({required this.entities});

  @override
  List<Object?> get props => [entities];
}

class OrderPurchasedHistoryBlocStateError
    extends OrderPurchasedHistoryBlocState {
  final String err;
  OrderPurchasedHistoryBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
