import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/couponRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';
import 'coupon_state.dart';
part 'coupon_event.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRepository _couponRepository = CouponRepository();
  CouponBloc() : super(CouponState.initial()) {
    on<ShowOwnCouponEvent>(getOwnCoupon);
    on<ShowCanGetCouponEvent>(getCanGetCoupon);
  }

  Future<void> getOwnCoupon(
      ShowOwnCouponEvent event, Emitter<CouponState> emit) async {
    List data;
    try {
      emit(state.copyWith(getCouponState: ApiState.loading));
      data = await _couponRepository.getOwnCoupon();
      emit(state.copyWith(
          getCouponState: ApiState.success, ownCouponList: data));
    } catch (e) {
      emit(state.copyWith(getCouponState: ApiState.fail));
    }
  }

  Future<void> getCanGetCoupon(
      ShowCanGetCouponEvent event, Emitter<CouponState> emit) async {
    List data;
    try {
      emit(state.copyWith(getCouponState: ApiState.loading));
      data = await _couponRepository.getCanGetCoupon();
      emit(state.copyWith(
          getCouponState: ApiState.success, ownCouponList: data));
    } catch (e) {
      emit(state.copyWith(getCouponState: ApiState.fail));
    }
  }
}
