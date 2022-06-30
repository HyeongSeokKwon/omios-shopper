import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:cloth_collection/repository/shopperRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'shopper_info_event.dart';
part 'shopper_info_state.dart';

class ShopperInfoBloc extends Bloc<ShopperInfoEvent, ShopperInfoState> {
  final HttpRepository _httpRepository = HttpRepository();
  final ShopperRepository _shopperRepository = ShopperRepository();
  final InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();
  ShopperInfoBloc() : super(ShopperInfoState.initial()) {
    on<GetShopperInfoEvent>(getShopperInfo);
    on<GetPointHistoryEvent>(getPointHistory);
    on<PointPagenationEvent>(pagenation);
    on<PatchShopperInfoEvent>(patchShopperInfo);
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

  Future<void> patchShopperInfo(
      PatchShopperInfoEvent event, Emitter<ShopperInfoState> emit) async {
    Map body = {};
    Map response;
    Map<String, dynamic> info;
    emit(state.copyWith(patchShopperInfoState: ApiState.loading));
    try {
      emit(state.copyWith(patchShopperInfoState: ApiState.initial));
      if (event.email != state.shopperInfo['email']) {
        body['email'] = event.email;
      }
      if (event.nickname != state.shopperInfo['nickname']) {
        body['nickname'] = event.nickname;
      }
      if (event.height != state.shopperInfo['height']) {
        body['height'] = event.height;
      }
      if (event.weight != state.shopperInfo['weight']) {
        body['weight'] = event.weight;
      }
      response = await _shopperRepository.patchShopperInfo(body);
      info = await _shopperRepository.getShopperInfo();
      emit(state.copyWith(
          patchShopperInfoState: ApiState.success, shopperInfo: info));
    } catch (e) {
      emit(state.copyWith(patchShopperInfoState: ApiState.fail));
    }
  }

  Future<void> getPointHistory(
      GetPointHistoryEvent event, Emitter<ShopperInfoState> emit) async {
    Map<String, dynamic> pointHistoryData;

    try {
      pointHistoryData = await _shopperRepository.getPointHistory(event.type);
      infinityScrollBloc.state.getData = pointHistoryData;
      emit(state.copyWith(
          pointHistory: pointHistoryData['results'],
          getPointHistoryState: ApiState.success));
    } catch (e) {
      emit(state.copyWith(getPointHistoryState: ApiState.fail));
    }
  }

  Future<void> pagenation(
      PointPagenationEvent event, Emitter<ShopperInfoState> emit) async {
    Map<String, dynamic> pointHistoryResponse;
    List pointHistoryList;
    if (infinityScrollBloc.state.getData['next'] != null) {
      try {
        Uri url = Uri.parse(infinityScrollBloc.state.getData['next']);

        pointHistoryResponse =
            await _httpRepository.httpGet(url.path, url.queryParameters);

        pointHistoryList = pointHistoryResponse['data']['results'];

        emit(
          state.copyWith(
            getPointHistoryState: ApiState.success,
            pointHistory: List.of(state.pointHistory)..addAll(pointHistoryList),
          ),
        );

        infinityScrollBloc.state.getData = pointHistoryResponse;
      } catch (e) {
        emit(state.copyWith(getPointHistoryState: ApiState.fail));
      }
    }
  }
}
