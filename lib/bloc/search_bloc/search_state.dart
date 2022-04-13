part of 'search_bloc.dart';

class SearchState extends Equatable {
  final FetchState searchState;
  final String searchWord;
  final Map<String, dynamic> searchBoxList;
  final List<dynamic> searchProductList;
  final bool isClickedSearchingButton;
  SearchState({
    required this.searchState,
    required this.searchWord,
    required this.searchBoxList,
    required this.searchProductList,
    required this.isClickedSearchingButton,
  });

  factory SearchState.initial() {
    return SearchState(
      searchState: FetchState.initial,
      searchBoxList: {},
      searchProductList: [],
      isClickedSearchingButton: false,
      searchWord: '',
    );
  }

  SearchState copyWith(
      {FetchState? searchState,
      Map<String, dynamic>? searchBoxList,
      List<dynamic>? searchProductList,
      bool? isClickedSearchingButton,
      String? searchWord}) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchBoxList: searchBoxList ?? this.searchBoxList,
      searchProductList: searchProductList ?? this.searchProductList,
      isClickedSearchingButton:
          isClickedSearchingButton ?? this.isClickedSearchingButton,
      searchWord: searchWord ?? this.searchWord,
    );
  }

  @override
  List<Object> get props => [
        searchState,
        searchBoxList,
        searchProductList,
        isClickedSearchingButton,
        searchWord
      ];
}
