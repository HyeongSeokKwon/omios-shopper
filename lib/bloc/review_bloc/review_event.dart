part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

class ClickSizeOpinionEvent extends ReviewEvent {
  final String content;

  const ClickSizeOpinionEvent({
    required this.content,
  });
}

class ClickColorOpinionEvent extends ReviewEvent {
  final String content;

  const ClickColorOpinionEvent({
    required this.content,
  });
}

class ClickQualityOpinionEvent extends ReviewEvent {
  final String content;

  const ClickQualityOpinionEvent({
    required this.content,
  });
}

class ClickAddPhotoEvent extends ReviewEvent {}

class ClickRemovePhotoEvent extends ReviewEvent {
  final int index;
  const ClickRemovePhotoEvent({required this.index});
}
