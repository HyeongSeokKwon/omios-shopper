import 'package:bloc/bloc.dart';
import 'package:cloth_collection/http/httpService.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'infinity_scroll_event.dart';
part 'infinity_scroll_state.dart';

class InfinityScrollBloc
    extends Bloc<InfinityScrollEvent, InfinityScrollState> {
  HttpService _httpService = HttpService();

  InfinityScrollBloc() : super(InfinityScrollState.initial()) {
    on<AddDataEvent>(addData);
    on<ResetDataEvent>(resetData);
  }

  Future<void> addData(
      AddDataEvent event, Emitter<InfinityScrollState> emit) async {
    Map<String, dynamic> response;
    Uri nextLink = Uri.parse(state.getData['next']);
    if (state.getData['next'] != null) {
      emit(state.copyWith(getState: FetchState.loading));
      response =
          await _httpService.httpGet(nextLink.path, nextLink.queryParameters);
      print(state.productData.length);
      emit(state.copyWith(
          getState: FetchState.success,
          productData: List.of(state.productData)
            ..addAll(response['data']['results']),
          getData: response['data']));

      print(state.productData.length);
    }
  }

  Future<void> resetData(
      ResetDataEvent event, Emitter<InfinityScrollState> emit) async {
    emit(state.copyWith(
        getState: FetchState.success,
        getData: event.getData,
        productData: event.getData['results']));
  }
}
