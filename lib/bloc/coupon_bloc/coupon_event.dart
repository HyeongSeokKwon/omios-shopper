part of 'coupon_bloc.dart';

abstract class CouponEvent extends Equatable {
  const CouponEvent();

  @override
  List<Object> get props => [];
}

class ShowCanGetCouponEvent extends CouponEvent {}

class ShowOwnCouponEvent extends CouponEvent {}

class ClickGetCouponEvent extends CouponEvent {
  final int id;

  const ClickGetCouponEvent({required this.id});
}
