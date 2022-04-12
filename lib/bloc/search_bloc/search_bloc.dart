import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/categoryRepository.dart';
import 'package:cloth_collection/repository/searchRepository.dart';
import 'package:equatable/equatable.dart';

import '../bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  CategoryRepository _categoryRepository = CategoryRepository();
  SearchRepository _searchRepository = SearchRepository();
  SearchBloc() : super(SearchState.initial()) {
    on<ChangeSearchingText>(getSearchingResult);
  }

  Future<void> getSearchingResult(
      ChangeSearchingText event, Emitter<SearchState> emit) async {
    if (event.text.isNotEmpty) {
      emit(state.copyWith(searchState: FetchState.loading));
      Map<String, dynamic> searchBoxResults = await getSearchBox(event.text);
      Map<String, dynamic> searchProductsResults =
          await getSearchProducts(event.text);

      _categoryRepository.getCategory();

      emit(state.copyWith(
          searchState: FetchState.success,
          searchBoxList: searchBoxResults,
          searchProductList: searchProductsResults));
    } else {
      emit(state.copyWith(searchState: FetchState.initial));
    }
  }

  Future<dynamic> getSearchBox(String text) async {
    Map results = await _searchRepository.getSearchBox(text);
    return results;
  }

  Future<dynamic> getSearchProducts(String text) async {
    Map results = await _searchRepository.getSearchProducts(text);
    return results;
  }
}
