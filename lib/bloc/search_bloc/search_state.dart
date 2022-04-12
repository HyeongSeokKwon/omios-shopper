part of 'search_bloc.dart';

class SearchState extends Equatable {
  final FetchState searchState;
  final Map<String, dynamic> searchBoxList;
  final Map<String, dynamic> searchProductList;
  SearchState({
    required this.searchState,
    required this.searchBoxList,
    required this.searchProductList,
  });

  factory SearchState.initial() {
    return SearchState(
        searchState: FetchState.initial,
        searchBoxList: {},
        searchProductList: {});
  }

  SearchState copyWith({
    FetchState? searchState,
    Map<String, dynamic>? searchBoxList,
    Map<String, dynamic>? searchProductList,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchBoxList: searchBoxList ?? this.searchBoxList,
      searchProductList: searchProductList ?? this.searchProductList,
    );
  }

  @override
  List<Object> get props => [searchState, searchBoxList, searchProductList];
}
