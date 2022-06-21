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

class ChangeProductsCountEvent extends CartEvent {
  final int id;
  final int count;

  const ChangeProductsCountEvent({required this.id, required this.count});
}

class SelectProductEvent extends CartEvent {
  final int index;
  final bool isChecked;
  const SelectProductEvent({
    required this.index,
    required this.isChecked,
  });
}

class ClickSelectAllProductButtonEvent extends CartEvent {
  final bool isChecked;

  const ClickSelectAllProductButtonEvent({required this.isChecked});
}

class ClickBuyButtonEvent extends CartEvent {}
