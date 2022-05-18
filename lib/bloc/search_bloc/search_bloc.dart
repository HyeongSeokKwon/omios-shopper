import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/repository/searchRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository _searchRepository = SearchRepository();
  InfinityScrollBloc infinityScrollBloc;
  SearchBloc({required this.infinityScrollBloc})
      : super(SearchState.initial()) {
    on<ChangeSearchingText>(getSearchBox);
    on<ClickedSearchButtonEvent>(getSearchProducts);
  }

  Future<void> getSearchBox(
      ChangeSearchingText event, Emitter<SearchState> emit) async {
    if (event.text.isNotEmpty) {
      emit(state.copyWith(
          searchState: ApiState.loading, isClickedSearchingButton: false));
      Map<String, dynamic> searchBoxResults =
          await _searchRepository.getSearchBox(event.text);

      emit(state.copyWith(
        searchState: ApiState.success,
        searchBoxList: searchBoxResults,
      ));
    } else {
      emit(state.copyWith(
          searchState: ApiState.initial, isClickedSearchingButton: true));
    }
  }

  Future<void> getSearchProducts(
      ClickedSearchButtonEvent event, Emitter<SearchState> emit) async {
    if (event.text.isNotEmpty) {
      emit(state.copyWith(
          searchState: ApiState.loading, searchWord: event.text));
      Map<String, dynamic> searchProductResults =
          await _searchRepository.getSearchProducts(event.text);
      infinityScrollBloc.state.getData = searchProductResults;
      infinityScrollBloc.state.targetDatas = searchProductResults['results'];
      emit(
        state.copyWith(
          searchState: ApiState.success,
          searchProductList: searchProductResults['results'],
          isClickedSearchingButton: true,
        ),
      );
    } else {
      emit(state.copyWith(searchState: ApiState.initial));
    }
  }
}
