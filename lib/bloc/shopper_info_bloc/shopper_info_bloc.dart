import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/shopperRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'shopper_info_event.dart';
part 'shopper_info_state.dart';

class ShopperInfoBloc extends Bloc<ShopperInfoEvent, ShopperInfoState> {
  final ShopperRepository _shopperRepository = ShopperRepository();
  ShopperInfoBloc() : super(ShopperInfoState.initial()) {
    on<GetShopperInfoEvent>(getShopperInfo);
  }

  Future<void> getShopperInfo(
      GetShopperInfoEvent event, Emitter<ShopperInfoState> emit) async {
    Map<String, dynamic> info;
    try {
      emit(state.copyWith(getShopperInfoState: ApiState.loading));
      info = await _shopperRepository.getShopperInfo();

      emit(state.copyWith(
          shopperInfo: info, getShopperInfoState: ApiState.success));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(getShopperInfoState: ApiState.fail));
    }
  }
}
