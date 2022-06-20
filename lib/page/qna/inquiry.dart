import 'dart:io';

import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';

class Inquiry extends StatefulWidget {
  final QnaBloc qnaBloc;
  Inquiry({Key? key, required this.qnaBloc}) : super(key: key);

  @override
  State<Inquiry> createState() => _InquiryState();
}

class _InquiryState extends State<Inquiry> {
  TextEditingController inqueryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.qnaBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/images/svg/moveToBack.svg",
                  width: 10 * Scale.width,
                  height: 20 * Scale.height,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 14 * Scale.width),
              Text("문의하기",
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 22.0)),
            ],
          ),
        ),
        body: scrollArea(),
        bottomSheet: completeButton(),
      ),
    );
  }

  Widget scrollArea() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        return Column(
          children: [
            questionTypeArea(),
            disclosure(),
            inquiryArea(),
          ],
        );
      },
    );
  }

  Widget inquiryDialog(String content, void Function() event) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("확인"),
              onPressed: () {
                event();
              }),
        ],
      );
    } else {
      return AlertDialog(
        content: Text(
          content,
          style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              "확인",
              style:
                  textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
            ),
            onPressed: () {
              event();
              //Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  Widget questionTypeArea() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        if (state.questionTypeGetState == ApiState.initial) {
          context.read<QnaBloc>().add(ClickQuestionTypeEvent());
          return progressBar();
        } else if (context.read<QnaBloc>().state.questionTypeGetState ==
            ApiState.success) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
                  child: Text(
                    "질문 유형",
                    style: textStyle(
                        Colors.black, FontWeight.w700, 'NotoSansKR', 19.0),
                  ),
                ),
                InkWell(
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            height: 45 * Scale.height,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[500]!),
                              borderRadius: BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.0 * Scale.width),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context
                                                .read<QnaBloc>()
                                                .state
                                                .selectedQuestionType !=
                                            -1
                                        ? context
                                                .read<QnaBloc>()
                                                .state
                                                .questionType[
                                            context
                                                .read<QnaBloc>()
                                                .state
                                                .selectedQuestionType]['name']
                                        : "선택해주세요",
                                    style: textStyle(Colors.grey[700]!,
                                        FontWeight.w400, 'NotoSansKR', 15.0),
                                  ),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      final categoryBloc = BlocProvider.of<QnaBloc>(context);
                      showModalBottomSheet<void>(
                        isDismissible: false,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: categoryBloc,
                          child: Stack(
                            children: [
                              BlocBuilder<QnaBloc, QnaState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    child: Container(
                                        width: 414 * Scale.width,
                                        height: 896 * Scale.height,
                                        color: Colors.transparent),
                                    onTap: Navigator.of(context).pop,
                                  );
                                },
                              ),
                              Positioned(
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.6,
                                  maxChildSize: 1.0,
                                  builder: (_, controller) {
                                    return Stack(children: [
                                      Container(
                                        width: 414 * Scale.width,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 22 * Scale.width),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: 25 * Scale.height,
                                                    bottom: 30 * Scale.height),
                                                child: Text("질문유형 선택",
                                                    style: textStyle(
                                                        const Color(0xff333333),
                                                        FontWeight.w700,
                                                        "NotoSansKR",
                                                        21.0)),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: ListView.separated(
                                                    itemCount: state
                                                        .questionType.length,
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return const Divider();
                                                    },
                                                    itemBuilder:
                                                        ((context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          context
                                                              .read<QnaBloc>()
                                                              .add(SelectQuestionTypeEvent(
                                                                  questionTypeIndex:
                                                                      index));

                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: SizedBox(
                                                          height:
                                                              70 * Scale.height,
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                context
                                                                        .read<
                                                                            QnaBloc>()
                                                                        .state
                                                                        .questionType[
                                                                    index]['name'],
                                                                style: textStyle(
                                                                    Colors
                                                                        .black,
                                                                    FontWeight
                                                                        .w300,
                                                                    "NotoSansKR",
                                                                    19.0),
                                                              ),
                                                              context
                                                                          .read<
                                                                              QnaBloc>()
                                                                          .state
                                                                          .selectedQuestionType ==
                                                                      index
                                                                  ? SvgPicture
                                                                      .asset(
                                                                          "assets/images/svg/accept.svg")
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ]);
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          );
        } else if (state.questionTypeGetState == ApiState.fail) {
          return ErrorCard();
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget disclosure() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10 * Scale.height, horizontal: 20 * Scale.width),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "공개 여부",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
              ),
              SizedBox(width: 20 * Scale.width),
              Transform.scale(
                scale: 0.8,
                child: SizedBox(
                  width: 25 * Scale.width,
                  height: 25 * Scale.width,
                  child: Checkbox(
                    activeColor: Colors.grey[500],
                    side: BorderSide(
                        color: Colors.grey[500]!, width: 1 * Scale.width),
                    value: context.read<QnaBloc>().state.disClosure,
                    onChanged: (value) {
                      context
                          .read<QnaBloc>()
                          .add(ClickDisClosureEvent(value: value!));
                    },
                  ),
                ),
              ),
              Text(
                "비공개",
                style: textStyle(
                    Colors.grey[600]!, FontWeight.w400, 'NotoSansKR', 13.0),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget inquiryArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
            child: Text(
              "문의내용",
              style:
                  textStyle(Colors.black, FontWeight.w700, 'NotoSansKR', 19.0),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 400 * Scale.height,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[600]!),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: inqueryController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: "문의 내용을 작성해주세요",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget completeButton() {
    return BlocConsumer<QnaBloc, QnaState>(
      // listenWhen: ((previous, current) =>
      //     previous.qnaValidate != current.qnaValidate),
      listener: ((context, state) {
        if (state.qnaValidate == ValidateState.fail &&
            state.validateErrorReason.isNotEmpty) {
          showDialog(
              context: context,
              builder: (context) =>
                  inquiryDialog(state.validateErrorReason, () {
                    Navigator.of(context).pop();
                  }));
        }
        if (state.postState == ApiState.success) {
          showDialog(
              context: context,
              builder: (context) => inquiryDialog("등록되었습니다", () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  }));
        }
      }),
      builder: (context, state) {
        return InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20 * Scale.width, vertical: 30 * Scale.height),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50 * Scale.height,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "완료",
                        style: textStyle(
                            Colors.white, FontWeight.w500, "NotoSansKR", 17.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<QnaBloc>()
                  .add(ClickCompleteEvent(inquery: inqueryController.text));

              context.read<QnaBloc>().add(ValidateDataEvent());
            });
      },
    );
  }
}
