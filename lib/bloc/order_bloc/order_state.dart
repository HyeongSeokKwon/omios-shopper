part of 'order_bloc.dart';

class OrderState extends Equatable {
  final List<OrderProduct> productCart;
  final ApiState registOrderState;
  final int totalProductPrice;
  final int baseDiscountPrice;
  final int membershipDiscountPrice;

  final int shippingPrice;
  final int usedPoint;
  final int canUsePoint;
  final int finalPaymentPrice;

  OrderState({
    required this.productCart,
    required this.registOrderState,
    required this.totalProductPrice,
    required this.baseDiscountPrice,
    required this.membershipDiscountPrice,
    required this.shippingPrice,
    required this.usedPoint,
    required this.canUsePoint,
    required this.finalPaymentPrice,
  });

  factory OrderState.initial() {
    return OrderState(
      productCart: [],
      registOrderState: ApiState.initial,
      totalProductPrice: 0,
      baseDiscountPrice: 0,
      membershipDiscountPrice: 0,
      shippingPrice: 3000,
      usedPoint: 0,
      canUsePoint: 0,
      finalPaymentPrice: 0,
    );
  }

  @override
  List<Object?> get props => [
        productCart,
        registOrderState,
        totalProductPrice,
        baseDiscountPrice,
        membershipDiscountPrice,
        shippingPrice,
        usedPoint,
        canUsePoint,
        finalPaymentPrice,
      ];

  OrderState copyWith({
    List<OrderProduct>? productCart,
    ApiState? registOrderState,
    int? totalProductPrice,
    int? baseDiscountPrice,
    int? membershipDiscountPrice,
    int? shippingPrice,
    int? usedPoint,
    int? canUsePoint,
    int? finalPaymentPrice,
  }) {
    return OrderState(
      productCart: productCart ?? this.productCart,
      registOrderState: registOrderState ?? this.registOrderState,
      totalProductPrice: totalProductPrice ?? this.totalProductPrice,
      baseDiscountPrice: baseDiscountPrice ?? this.baseDiscountPrice,
      membershipDiscountPrice:
          membershipDiscountPrice ?? this.membershipDiscountPrice,
      shippingPrice: shippingPrice ?? this.shippingPrice,
      usedPoint: usedPoint ?? this.usedPoint,
      canUsePoint: canUsePoint ?? this.canUsePoint,
      finalPaymentPrice: finalPaymentPrice ?? this.finalPaymentPrice,
    );
  }
}
