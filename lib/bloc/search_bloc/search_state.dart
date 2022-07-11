part of 'search_bloc.dart';

class SearchState extends Equatable {
  final ApiState searchState;
  final ApiState recentSearchesState;
  final String searchWord;
  final Map<String, dynamic> searchBoxList;
  final List<dynamic> searchProductList;
  final List<dynamic> recentSearches;
  final bool isClickedSearchingButton;
  SearchState({
    required this.searchState,
    required this.recentSearchesState,
    required this.searchWord,
    required this.searchBoxList,
    required this.searchProductList,
    required this.recentSearches,
    required this.isClickedSearchingButton,
  });

  factory SearchState.initial() {
    return SearchState(
      searchState: ApiState.initial,
      recentSearchesState: ApiState.initial,
      searchBoxList: {},
      searchProductList: [],
      recentSearches: [],
      isClickedSearchingButton: false,
      searchWord: '',
    );
  }

  SearchState copyWith(
      {ApiState? searchState,
      ApiState? recentSearchesState,
      Map<String, dynamic>? searchBoxList,
      List<dynamic>? searchProductList,
      List<dynamic>? recentSearches,
      bool? isClickedSearchingButton,
      String? searchWord}) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      recentSearchesState: recentSearchesState ?? this.recentSearchesState,
      searchBoxList: searchBoxList ?? this.searchBoxList,
      searchProductList: searchProductList ?? this.searchProductList,
      recentSearches: recentSearches ?? this.recentSearches,
      isClickedSearchingButton:
          isClickedSearchingButton ?? this.isClickedSearchingButton,
      searchWord: searchWord ?? this.searchWord,
    );
  }

  @override
  List<Object> get props => [
        searchState,
        recentSearchesState,
        searchBoxList,
        searchProductList,
        recentSearches,
        isClickedSearchingButton,
        searchWord
      ];
}
