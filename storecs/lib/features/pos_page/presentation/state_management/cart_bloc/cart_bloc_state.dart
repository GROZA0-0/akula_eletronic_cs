import 'package:equatable/equatable.dart';
import 'package:storecs/features/pos_page/domain/enitities/cart_entities.dart';

abstract class CartBlocState extends Equatable {}

class CartBlocStateLoading extends CartBlocState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class CartBlocStateLoaded extends CartBlocState {
  List<CartEntities> cartItems;
  CartBlocStateLoaded({required this.cartItems});
  @override
  List<Object?> get props => [cartItems];
}

class CartBlocStateError extends CartBlocState {
  final String err;
  CartBlocStateError({required this.err});

  @override
  List<Object?> get props => [err];
}
