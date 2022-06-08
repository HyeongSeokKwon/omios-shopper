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
    on<ChangeProductsCountEvent>(changeProductsCount);
    on<SelectProductEvent>(selectProduct);
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
      response = await _cartRepository.getItemFromCarts();
      for (var value in response['results']) {
        value['product_price'] = value['carts'][0]['base_discounted_price'] /
            value['carts'][0]['count'];
      }
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

  Future<void> changeProductsCount(
      ChangeProductsCountEvent event, Emitter<CartState> emit) async {
    Map response;
    Map getDatareponse;
    Map body = {};
    body['count'] = event.count;
    try {
      // emit(state.copyWith(patchCartsState: ApiState.loading));
      response = await _cartRepository.patchItemFromCart(event.id, body);
      getDatareponse = await _cartRepository.getItemFromCarts();
      print("response");
      print(response);
      print("*******************");
      emit(state.copyWith(
        patchCartsState: ApiState.success,
        getCartsData: getDatareponse['results'],
      ));
    } catch (e) {
      emit(state.copyWith(patchCartsState: ApiState.fail));
    }
  }

  void selectProduct(SelectProductEvent event, Emitter<CartState> emit) {
    List copy = [...state.selectedProducts];
    if (event.isChecked) {
      copy.add(event.index);
    } else {
      copy.remove(event.index);
    }

    emit(state.copyWith(selectedProducts: copy));
    print(state.selectedProducts);
  }
}
