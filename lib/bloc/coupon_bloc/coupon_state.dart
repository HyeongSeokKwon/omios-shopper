part of 'coupon_bloc.dart';

class CouponState extends Equatable {
  final ApiState ownCouponState;
  final ApiState canGetCouponState;
  final List canGetConponList;
  final List ownCouponList;

  CouponState({
    required this.ownCouponState,
    required this.canGetCouponState,
    required this.canGetConponList,
    required this.ownCouponList,
  });

  factory CouponState.initial() {
    return CouponState(
        ownCouponState: ApiState.initial,
        canGetCouponState: ApiState.initial,
        canGetConponList: [],
        ownCouponList: []);
  }

  @override
  List<Object> get props =>
      [ownCouponState, canGetCouponState, canGetConponList, ownCouponList];

  CouponState copyWith({
    ApiState? ownCouponState,
    ApiState? canGetCouponState,
    List? canGetConponList,
    List? ownCouponList,
  }) {
    return CouponState(
      ownCouponState: ownCouponState ?? this.ownCouponState,
      canGetCouponState: canGetCouponState ?? this.canGetCouponState,
      canGetConponList: canGetConponList ?? this.canGetConponList,
      ownCouponList: ownCouponList ?? this.ownCouponList,
    );
  }
}
