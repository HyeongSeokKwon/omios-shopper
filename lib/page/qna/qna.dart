import 'package:cloth_collection/bloc/bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    qnaBloc = QnaBloc(productId: widget.productId);
    return BlocProvider(
      create: (context) => qnaBloc,
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
      ),
    );
  }

  Widget scrollArea() {
    return BlocBuilder<QnaBloc, QnaState>(
      builder: (context, state) {
        if (state.qnaGetState == FetchState.initial) {
          context.read<QnaBloc>().add(InitQnaPageEvent());
          return SizedBox();
        } else if (state.qnaGetState == FetchState.fail) {
          return ErrorCard();
        } else if (state.qnaGetState == FetchState.success) {
          return SingleChildScrollView(
            child: Column(children: [
              qnaButton(),
              qnaListView(),
            ]),
          );
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget qnaButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Inquiry(
              qnaBloc: qnaBloc,
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
          itemCount: context.read<QnaBloc>().state.qnaList.length,
          itemBuilder: ((context, index) {
            return context.read<QnaBloc>().state.qnaList[index]['is_secret'] ==
                    false
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10 * Scale.height),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "상품명$index",
                          style: textStyle(Colors.grey[500]!, FontWeight.w400,
                              "NotoSansKR", 13.0),
                        ),
                        SizedBox(height: 5 * Scale.height),
                        Text(
                          "Q: ${context.read<QnaBloc>().state.qnaList[index]['question']}",
                          style: textStyle(Colors.black, FontWeight.w500,
                              "NotoSansKR", 14.0),
                        ),
                        SizedBox(height: 5 * Scale.height),
                        context.read<QnaBloc>().state.qnaList[index]
                                    ['answer'] !=
                                null
                            ? Text(
                                "A: omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,omios가 작성한 대답,",
                                style: textStyle(Colors.black, FontWeight.w400,
                                    "NotoSansKR", 14.0),
                              )
                            : SizedBox(),
                        SizedBox(height: 5 * Scale.height),
                        Text(
                          "${context.read<QnaBloc>().state.qnaList[index]['created_at']}",
                          style: textStyle(Colors.grey[500]!, FontWeight.w400,
                              "NotoSansKR", 13.0),
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
}
