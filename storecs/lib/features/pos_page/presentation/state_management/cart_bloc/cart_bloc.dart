import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storecs/features/pos_page/presentation/state_management/cart_bloc/cart_bloc_event.dart';
import 'package:storecs/features/pos_page/presentation/state_management/cart_bloc/cart_bloc_state.dart';
import 'package:storecs/features/pos_page/presentation/state_management/cart_controller.dart';

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  final CartController controller;
  CartBloc({required this.controller}) : super(CartBlocStateLoading()) {
    on<CartBlocEventLoading>((event, emit) async {
      emit(CartBlocStateLoading());
      try {
        // final cartItems =  controller.addToCart(state.)
      } catch (e) {}
    });
  }
}
