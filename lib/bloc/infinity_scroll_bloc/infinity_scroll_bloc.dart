import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'infinity_scroll_event.dart';
part 'infinity_scroll_state.dart';

class InfinityScrollBloc
    extends Bloc<InfinityScrollEvent, InfinityScrollState> {
  HttpRepository httpRepository = HttpRepository();

  InfinityScrollBloc() : super(InfinityScrollState.initial()) {
    on<AddDataEvent>(addData);
    on<ResetDataEvent>(resetData);
  }

  Future<void> addData(
      AddDataEvent event, Emitter<InfinityScrollState> emit) async {
    Map<String, dynamic> response;
    if (state.getData['next'] != null) {
      Uri nextLink = Uri.parse(state.getData['next']);
      emit(state.copyWith(getState: ApiState.loading));
      response =
          await httpRepository.httpGet(nextLink.path, nextLink.queryParameters);
      emit(state.copyWith(
          getState: ApiState.success,
          targetDatas: List.of(state.targetDatas)
            ..addAll(response['data']['results']),
          getData: response['data']));
    }
  }

  Future<void> resetData(
      ResetDataEvent event, Emitter<InfinityScrollState> emit) async {
    emit(state.copyWith(
        getState: ApiState.success,
        getData: event.getData,
        targetDatas: event.getData['results']));
  }
}
