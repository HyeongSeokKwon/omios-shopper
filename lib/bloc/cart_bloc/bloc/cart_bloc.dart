import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/cart_bloc/bloc/cart_state.dart';
import 'package:cloth_collection/repository/cartRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../model/orderProduct.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();
  CartBloc() : super(CartState.initial()) {
    on<ClickShoppingBasketEvent>(registItemToCarts);
    on<GetCartsProductEvent>(getCartsProduct);
  }

  Future<void> registItemToCarts(
      ClickShoppingBasketEvent event, Emitter<CartState> emit) async {
    Map response;
    Map body = {};
    body['variable'] = [];
    for (OrderProduct orderProduct in event.cart) {
      body['variable']
          .add({'option': orderProduct.optionId, 'count': orderProduct.count});
    }
    try {
      response = await _cartRepository.registItemToCarts(body);
    } catch (e) {
      emit(state.copyWith(registToCartState: ApiState.fail));
    }
  }

  Future<void> getCartsProduct(
      GetCartsProductEvent event, Emitter<CartState> emit) async {
    Map response;
    try {
      response = await _cartRepository.getItemFromCarts();
    } catch (e) {
      emit(state.copyWith(getCartsState: ApiState.fail));
    }
  }
}
