import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/repository/qnaRepository.dart';
import 'package:equatable/equatable.dart';

part 'qna_event.dart';
part 'qna_state.dart';

class QnaBloc extends Bloc<QnaEvent, QnaState> {
  final QnaRepository _qnaRepository = QnaRepository();
  final int productId;
  QnaBloc({required this.productId}) : super(QnaState.initial()) {
    on<InitQnaPageEvent>(initQnaList);
    on<ClickQuestionTypeEvent>(clickQuestionType);
    on<SelectQuestionTypeEvent>(selectQuestionType);
    on<ClickDisClosureEvent>(clickDisclousre);
    on<ClickCompleteEvent>(clickComplete);
    on<ValidateDataEvent>(registQnaData);
  }

  Future<void> initQnaList(
      InitQnaPageEvent event, Emitter<QnaState> emit) async {
    List qnaList;
    try {
      emit(state.copyWith(qnaGetState: FetchState.loading));
      qnaList = await _qnaRepository.getQnaList(productId);
      emit(state.copyWith(qnaGetState: FetchState.success, qnaList: qnaList));
    } catch (e) {
      emit(state.copyWith(qnaGetState: FetchState.fail));
    }
  }

  Future<void> clickQuestionType(
      ClickQuestionTypeEvent event, Emitter<QnaState> emit) async {
    List questionType;
    try {
      emit(state.copyWith(questionTypeGetState: FetchState.loading));
      questionType = await _qnaRepository.getQuestionClassification();
      emit(state.copyWith(
          questionTypeGetState: FetchState.success,
          questionType: questionType));
    } catch (e) {
      emit(state.copyWith(questionTypeGetState: FetchState.fail));
    }
  }

  void selectQuestionType(
      SelectQuestionTypeEvent event, Emitter<QnaState> emit) {
    emit(state.copyWith(
        qnaValidate: ValidateState.initial,
        selectedQuestionType: event.questionTypeIndex));
  }

  void clickDisclousre(ClickDisClosureEvent event, Emitter<QnaState> emit) {
    emit(state.copyWith(
        qnaValidate: ValidateState.initial, disClosure: event.value));
  }

  void clickComplete(ClickCompleteEvent event, Emitter<QnaState> emit) {
    final String notSelectedQuestionType = '질문유형을 선택해주세요';
    final String inValidInquiryLength = '내용은 최소 1자, 최대 1000자 입니다.';
    emit(state.copyWith(
        inquiry: event.inquery,
        postState: FetchState.initial,
        qnaValidate: ValidateState.initial));
    if (state.selectedQuestionType == -1) {
      emit(state.copyWith(
        qnaValidate: ValidateState.fail,
        validateErrorReason: notSelectedQuestionType,
      ));
      return;
    } else if (state.inquiry.isEmpty || state.inquiry.length > 1000) {
      emit(state.copyWith(
          validateErrorReason: inValidInquiryLength,
          qnaValidate: ValidateState.fail));
      return;
    } else {
      emit(state.copyWith(
          validateErrorReason: '',
          qnaValidate: ValidateState.success,
          inquiry: event.inquery));
    }
  }

  Future<void> registQnaData(
      ValidateDataEvent event, Emitter<QnaState> emit) async {
    Map response;
    Map<String, dynamic> body;
    if (state.qnaValidate == ValidateState.success) {
      try {
        body = {
          "question": state.inquiry,
          "is_secret": state.disClosure,
          "classification": state.selectedQuestionType + 1,
        };

        response = await _qnaRepository.postQuestion(productId, body);
        print("success");
        emit(state.copyWith(
            qnaValidate: ValidateState.success, postState: FetchState.success));
      } catch (e) {
        emit(state.copyWith(
            validateErrorReason: '', postState: FetchState.fail));
      }
    }
  }
}
