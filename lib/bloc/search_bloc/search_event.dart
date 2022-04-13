part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class ChangeSearchingText extends SearchEvent {
  final String text;

  ChangeSearchingText({
    required this.text,
  });
}

class ClickedSubCategoryEvent extends SearchEvent {
  final int subId;
  ClickedSubCategoryEvent({
    required this.subId,
  });
}

class ClickedSearchButtonEvent extends SearchEvent {
  final String text;
  ClickedSearchButtonEvent({required this.text});
}
