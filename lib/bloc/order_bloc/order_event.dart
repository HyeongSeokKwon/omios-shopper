part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class AddProductToCartEvent extends OrderEvent {
  final List<OrderProduct> orderProduct;

  const AddProductToCartEvent({required this.orderProduct});
}

class RegistOrderEvent extends OrderEvent {}
