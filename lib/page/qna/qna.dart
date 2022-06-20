import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/page/qna/inquiry.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class QnA extends StatefulWidget {
  final int productId;

  const QnA({Key? key, required this.productId}) : super(key: key);
  @override
  State<QnA> createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  late final QnaBloc qnaBloc;
  final InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();

  @override
  Widget build(BuildContext context) {
    qnaBloc = QnaBloc(
        productId: widget.productId, infinityScrollBloc: infinityScrollBloc);
    return BlocProvider(
      create: (BuildContext context) => infinityScrollBloc,
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
        body: QnaScrollArea(
          qnaBloc: qnaBloc,
        ),
      ),
    );
  }
}

class QnaScrollArea extends StatefulWidget {
  final QnaBloc qnaBloc;
  QnaScrollArea({Key? key, required this.qnaBloc}) : super(key: key);

  @override
  State<QnaScrollArea> createState() => _QnaScrollAreaState();
}

class _QnaScrollAreaState extends State<QnaScrollArea> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        context.read<InfinityScrollBloc>().add(AddDataEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return scrollArea();
  }

  Widget scrollArea() {
    return BlocProvider(
      create: (context) => widget.qnaBloc,
      child: BlocBuilder<InfinityScrollBloc, InfinityScrollState>(
        builder: (context, state) {
          return BlocBuilder<QnaBloc, QnaState>(
            builder: (context, state) {
              if (state.qnaGetState == ApiState.initial) {
                context.read<QnaBloc>().add(InitQnaPageEvent());
                return SizedBox();
              } else if (state.qnaGetState == ApiState.fail) {
                return ErrorCard();
              } else if (state.qnaGetState == ApiState.success) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(children: [
                    qnaButton(),
                    showDisclosure(),
                    qnaListView(),
                  ]),
                );
              } else {
                return progressBar();
              }
            },
          );
        },
      ),
    );
  }

  Widget qnaButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Inquiry(
              qnaBloc: widget.qnaBloc,
            ),
          ));
        },
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 40 * Scale.height,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(7),
                  ),
                ),
                child: Center(
                    child: Text(
                  "문의하기",
                  style: textStyle(
                      Colors.white, FontWeight.w500, "NotoSansKR", 15),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget qnaListView() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              context.read<InfinityScrollBloc>().state.targetDatas.length,
          itemBuilder: ((context, index) {
            return context.read<InfinityScrollBloc>().state.targetDatas[index]
                            ['is_secret'] ==
                        false ||
                    context.read<QnaBloc>().state.exceptDisclosure == false
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10 * Scale.height),
                    child: context
                                .read<InfinityScrollBloc>()
                                .state
                                .targetDatas[index]['is_secret'] ==
                            false
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "상품명$index",
                                style: textStyle(Colors.grey[500]!,
                                    FontWeight.w400, "NotoSansKR", 13.0),
                              ),
                              SizedBox(height: 5 * Scale.height),
                              Text(
                                "Q: ${context.read<InfinityScrollBloc>().state.targetDatas[index]['question']}",
                                style: textStyle(Colors.black, FontWeight.w500,
                                    "NotoSansKR", 14.0),
                              ),
                              SizedBox(height: 5 * Scale.height),
                              context
                                      .read<InfinityScrollBloc>()
                                      .state
                                      .targetDatas[index]['answer']
                                      .isNotEmpty
                                  ? Text(
                                      "A: ${context.read<InfinityScrollBloc>().state.targetDatas[index]['answer']}",
                                      style: textStyle(Colors.black,
                                          FontWeight.w400, "NotoSansKR", 14.0),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 5 * Scale.height),
                              Text(
                                "${context.read<InfinityScrollBloc>().state.targetDatas[index]['created_at']}",
                                style: textStyle(Colors.grey[500]!,
                                    FontWeight.w400, "NotoSansKR", 13.0),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "상품명$index",
                                style: textStyle(Colors.grey[500]!,
                                    FontWeight.w400, "NotoSansKR", 13.0),
                              ),
                              SizedBox(height: 5 * Scale.height),
                              Text(
                                "비공개 글입니다.",
                                style: textStyle(Colors.black, FontWeight.w500,
                                    "NotoSansKR", 14.0),
                              ),
                              SizedBox(height: 5 * Scale.height),
                              Text(
                                "${context.read<InfinityScrollBloc>().state.targetDatas[index]['created_at']}",
                                style: textStyle(Colors.grey[500]!,
                                    FontWeight.w400, "NotoSansKR", 13.0),
                              ),
                            ],
                          ),
                  )
                : SizedBox();
          }),
        );
      },
    );
  }

  Widget showDisclosure() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10 * Scale.height, horizontal: 20 * Scale.width),
          child: InkWell(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "비밀글 제외",
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 14.0),
                ),
                Transform.scale(
                  scale: 0.8,
                  child: SizedBox(
                    width: 25 * Scale.width,
                    height: 25 * Scale.width,
                    child: Checkbox(
                      activeColor: Colors.grey[500],
                      side: BorderSide(
                          color: Colors.grey[500]!, width: 1 * Scale.width),
                      value: context.read<QnaBloc>().state.exceptDisclosure,
                      onChanged: (value) {
                        context
                            .read<QnaBloc>()
                            .add(ClickExceptDisclosure(value: value!));
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
            onTap: () {
              context
                  .read<QnaBloc>()
                  .add(ClickExceptDisclosure(value: !state.exceptDisclosure));
            },
          ),
        );
      },
    );
  }
}
