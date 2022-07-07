import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/cart_bloc/bloc/cart_state.dart';
import 'package:cloth_collection/repository/cartRepository.dart';
import 'package:cloth_collection/repository/productRepository.dart';
import 'package:equatable/equatable.dart';

import '../../../model/orderProduct.dart';
part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository = CartRepository();
  final ProductRepository _productRepository = ProductRepository();
  OrderBloc orderBloc;
  CartBloc({required this.orderBloc}) : super(CartState.initial()) {
    on<ClickShoppingBasketEvent>(registItemToCarts);
    on<GetCartsProductEvent>(getCartsProduct);
    on<RemoveCartProductsEvent>(removeCartProducts);
    on<ChangeProductsCountEvent>(changeProductsCount);
    on<SelectProductEvent>(selectProduct);
    on<ClickSelectAllProductButtonEvent>(clickSelectAllProductButton);
    on<ClickBuyButtonEvent>(clickBuyButton);
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
      emit(state.copyWith(registToCartState: ApiState.success));
    } catch (e) {
      emit(state.copyWith(registToCartState: ApiState.fail));
    }
  }

  Future<void> getCartsProduct(
      GetCartsProductEvent event, Emitter<CartState> emit) async {
    Map response;
    if (await _productRepository.isRefreshExpired()) {
      emit(state.copyWith(getCartsState: ApiState.unauthenticated));
      return;
    }
    try {
      response = await _cartRepository.getItemFromCarts();
      for (var value in response['results']) {
        value['product_price'] = value['carts'][0]['base_discounted_price'] /
            value['carts'][0]['count'];
      }
      emit(
        state.copyWith(
          getCartsState: ApiState.success,
          getCartsResponse: response,
          getCartsData: response['results'],
          selectedProductsId:
              List.generate(response['results'].length, (index) => index),
        ),
      );
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
        getCartsResponse: response,
        getCartsData: response['results'],
      ));
    } catch (e) {
      emit(state.copyWith(deleteCartsState: ApiState.fail));
    }
  }

  Future<void> changeProductsCount(
      ChangeProductsCountEvent event, Emitter<CartState> emit) async {
    Map response;
    Map getDataResponse;
    Map body = {};
    body['count'] = event.count;
    try {
      response = await _cartRepository.patchItemFromCart(event.id, body);
      getDataResponse = await _cartRepository.getItemFromCarts();

      emit(state.copyWith(
        patchCartsState: ApiState.success,
        getCartsResponse: getDataResponse,
        getCartsData: getDataResponse['results'],
      ));
    } catch (e) {
      emit(state.copyWith(patchCartsState: ApiState.fail));
    }
  }

  Future<void> clickBuyButton(
      ClickBuyButtonEvent event, Emitter<CartState> emit) async {
    Map response;
    List productIdList = [];
    List<OrderProduct> orderProducts = [];
    List productList;
    try {
      for (var value in state.selectedProductsId) {
        productIdList.add(state.getCartsData[value]['product_id'].toString());
      }

      response = await _productRepository.getProductInfoByIdList(productIdList);

      productList = response['results'];

      for (int index = 0; index < productList.length; index++) {
        for (var option in state.getCartsData[index]['carts']) {
          orderProducts.add(
            OrderProduct(
                color: option['display_color_name'],
                size: option['size'],
                name: productList[index]['name'],
                imageUrl: productList[index]['main_image'],
                optionId: option['option'],
                baseDiscountedPrice: productList[index]
                    ['base_discounted_price'],
                baseDiscountRate: productList[index]['base_discount_rate'],
                count: option['count'],
                salePrice: productList[index]['sale_price']),
          );
        }
      }
      emit(state.copyWith(selectedProduct: orderProducts));
      orderBloc.add(AddProductToCartEvent(orderProduct: orderProducts));
    } catch (e) {}
  }

  void selectProduct(SelectProductEvent event, Emitter<CartState> emit) {
    List<int> selectedProductsId = [...state.selectedProductsId];
    if (event.isChecked) {
      selectedProductsId.add(event.index);
      emit(state.copyWith(selectedProductsId: selectedProductsId));
    } else {
      selectedProductsId.remove(event.index);
      emit(state.copyWith(selectedProductsId: selectedProductsId));
    }
  }

  void clickSelectAllProductButton(
      ClickSelectAllProductButtonEvent event, Emitter<CartState> emit) {
    if (event.isChecked) {
      emit(state.copyWith(
          selectedProductsId:
              List.generate(state.getCartsData.length, (index) => index)));
      return;
    } else {
      emit(state.copyWith(selectedProductsId: []));
      return;
    }
  }
}
