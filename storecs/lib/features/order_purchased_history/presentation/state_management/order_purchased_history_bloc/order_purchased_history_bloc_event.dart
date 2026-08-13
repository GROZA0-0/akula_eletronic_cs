import 'package:equatable/equatable.dart';

abstract class OrderPurchasedHistoryBlocEvent extends Equatable {}

class OrderPurchasedHistoryBlocEventLoading
    extends OrderPurchasedHistoryBlocEvent {
  @override
  List<Object?> get props => [];
}

class OrderPurchasedHistoryBlocEventError
    extends OrderPurchasedHistoryBlocEvent {
  final String err;
  OrderPurchasedHistoryBlocEventError({required this.err});

  @override
  List<Object?> get props => [err];
}
