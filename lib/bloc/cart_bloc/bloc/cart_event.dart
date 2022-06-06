part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class ClickShoppingBasketEvent extends CartEvent {
  final List<OrderProduct> cart;
  const ClickShoppingBasketEvent({required this.cart});
}

class GetCartsProductEvent extends CartEvent {}

class RemoveCartProductsEvent extends CartEvent {
  final List<int> idList;

  RemoveCartProductsEvent(
    this.idList,
  );
}
