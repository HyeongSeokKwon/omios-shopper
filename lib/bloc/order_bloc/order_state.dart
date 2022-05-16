part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<OrderProduct> productCart;
  final ApiState registOrderState;

  OrderState({
    required this.productCart,
    required this.registOrderState,
  });

  factory OrderState.initial() {
    return OrderState(productCart: [], registOrderState: ApiState.initial);
  }

  @override
  List<Object> get props => [productCart, registOrderState];

  OrderState copyWith({
    List<OrderProduct>? productCart,
    ApiState? registOrderState,
  }) {
    return OrderState(
      productCart: productCart ?? this.productCart,
      registOrderState: registOrderState ?? this.registOrderState,
    );
  }
}
