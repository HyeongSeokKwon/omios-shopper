import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/database/db.dart';
import 'package:cloth_collection/repository/searchRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository _searchRepository = SearchRepository();
  InfinityScrollBloc infinityScrollBloc;
  DBHelper dbHelper = DBHelper();
  SearchBloc({required this.infinityScrollBloc})
      : super(SearchState.initial()) {
    on<ChangeSearchingText>(getSearchBox);
    on<ClickedSearchButtonEvent>(getSearchProducts);
    on<ShowRecentSearchesEvent>(showRecentSearches);
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
      if (!state.recentSearches.contains({'searches': event.text})) {
        await deleteRecentSearches(dbHelper.db, event.text);
      }
      await setRecentSearches(dbHelper.db, event.text);
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

  Future<void> showRecentSearches(
      ShowRecentSearchesEvent event, Emitter<SearchState> emit) async {
    final List<dynamic> recentSearchResult =
        await getRecentSearches(dbHelper.db);
    emit(state.copyWith(
        recentSearchesState: ApiState.success,
        recentSearches: recentSearchResult));
  }
}
