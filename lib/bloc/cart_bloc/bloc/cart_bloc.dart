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
    on<RemoveCartProductsEvent>(removeCartProducts);
  }

  Future<void> registItemToCarts(
      ClickShoppingBasketEvent event, Emitter<CartState> emit) async {
    Map response;
    List body = [];

    for (OrderProduct orderProduct in event.cart) {
      body.add({'option': orderProduct.optionId, 'count': orderProduct.count});
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
      emit(state.copyWith(getCartsState: ApiState.loading));
      response = await _cartRepository.getItemFromCarts();
      emit(state.copyWith(
          getCartsState: ApiState.success, getCartsData: response['results']));
    } catch (e) {
      emit(state.copyWith(
        getCartsState: ApiState.fail,
      ));
    }
  }

  Future<void> removeCartProducts(
      RemoveCartProductsEvent event, Emitter<CartState> emit) async {
    Map response;
    try {
      emit(state.copyWith(deleteCartsState: ApiState.loading));
      response = await _cartRepository.deleteItemFromCart(event.idList);
      response = await _cartRepository.getItemFromCarts();
      emit(state.copyWith(
          deleteCartsState: ApiState.success,
          getCartsData: response['results']));
    } catch (e) {
      emit(state.copyWith(deleteCartsState: ApiState.fail));
    }
  }
}
