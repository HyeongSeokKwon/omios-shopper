part of 'qna_bloc.dart';

enum ValidateState { fail, success, initial }

class QnaState extends Equatable {
  final ApiState qnaGetState;
  final ApiState questionTypeGetState;
  final ApiState postState;
  final List qnaList;
  final List questionType;
  final bool disClosure;
  final int selectedQuestionType;
  final String inquiry;
  final ValidateState qnaValidate;
  final String validateErrorReason;

  QnaState({
    required this.qnaGetState,
    required this.questionTypeGetState,
    required this.postState,
    required this.qnaList,
    required this.questionType,
    required this.disClosure,
    required this.selectedQuestionType,
    required this.inquiry,
    required this.qnaValidate,
    required this.validateErrorReason,
  });

  factory QnaState.initial() {
    return QnaState(
      qnaGetState: ApiState.initial,
      questionTypeGetState: ApiState.initial,
      postState: ApiState.initial,
      qnaList: [],
      questionType: [],
      disClosure: false,
      inquiry: '',
      selectedQuestionType: -1,
      qnaValidate: ValidateState.initial,
      validateErrorReason: '',
    );
  }

  @override
  List<Object> get props => [
        postState,
        qnaGetState,
        questionTypeGetState,
        qnaList,
        questionType,
        disClosure,
        selectedQuestionType,
        inquiry,
        qnaValidate,
        validateErrorReason
      ];

  QnaState copyWith({
    ApiState? postState,
    ApiState? qnaGetState,
    ApiState? questionTypeGetState,
    List? qnaList,
    List? questionType,
    bool? disClosure,
    int? selectedQuestionType,
    String? inquiry,
    ValidateState? qnaValidate,
    String? validateErrorReason,
  }) {
    return QnaState(
      qnaGetState: qnaGetState ?? this.qnaGetState,
      questionTypeGetState: questionTypeGetState ?? this.questionTypeGetState,
      postState: postState ?? this.postState,
      qnaList: qnaList ?? this.qnaList,
      questionType: questionType ?? this.questionType,
      disClosure: disClosure ?? this.disClosure,
      selectedQuestionType: selectedQuestionType ?? this.selectedQuestionType,
      inquiry: inquiry ?? this.inquiry,
      qnaValidate: qnaValidate ?? this.qnaValidate,
      validateErrorReason: validateErrorReason ?? this.validateErrorReason,
    );
  }
}
