part of 'qna_bloc.dart';

abstract class QnaEvent extends Equatable {
  const QnaEvent();

  @override
  List<Object> get props => [];
}

class InitQnaPageEvent extends QnaEvent {}

class ClickQuestionTypeEvent extends QnaEvent {}

class ClickExceptDisclosure extends QnaEvent {
  final bool value;
  const ClickExceptDisclosure({required this.value});
}

class SelectQuestionTypeEvent extends QnaEvent {
  final int questionTypeIndex;
  const SelectQuestionTypeEvent({required this.questionTypeIndex});
}

class ClickDisClosureEvent extends QnaEvent {
  final bool value;
  const ClickDisClosureEvent({
    required this.value,
  });
}

class ClickCompleteEvent extends QnaEvent {
  final String inquery;
  const ClickCompleteEvent({required this.inquery});
}

class ValidateDataEvent extends QnaEvent {}
