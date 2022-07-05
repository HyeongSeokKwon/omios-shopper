import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/repository/couponRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';
part 'coupon_state.dart';
part 'coupon_event.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponRepository _couponRepository = CouponRepository();
  InfinityScrollBloc infinityScrollBloc;
  CouponBloc(this.infinityScrollBloc) : super(CouponState.initial()) {
    on<ShowOwnCouponEvent>(getOwnCoupon);
    on<ShowCanGetCouponEvent>(getCanGetCoupon);
  }

  Future<void> getOwnCoupon(
      ShowOwnCouponEvent event, Emitter<CouponState> emit) async {
    List data;
    try {
      emit(state.copyWith(ownCouponState: ApiState.loading));
      data = await _couponRepository.getOwnCoupon();
      emit(state.copyWith(
          ownCouponState: ApiState.success, ownCouponList: data));
    } catch (e) {
      emit(state.copyWith(ownCouponState: ApiState.fail));
    }
  }

  Future<void> getCanGetCoupon(
      ShowCanGetCouponEvent event, Emitter<CouponState> emit) async {
    Map<String, dynamic> data;
    try {
      emit(state.copyWith(canGetCouponState: ApiState.loading));
      data = await _couponRepository.getCanGetCoupon();
      infinityScrollBloc.state.getData = data;
      infinityScrollBloc.state.targetDatas = data['results'];

      print(data);
      emit(
        state.copyWith(
          canGetCouponState: ApiState.success,
          ownCouponList: data['results'],
        ),
      );
    } catch (e) {
      emit(state.copyWith(canGetCouponState: ApiState.fail));
    }
  }
}
