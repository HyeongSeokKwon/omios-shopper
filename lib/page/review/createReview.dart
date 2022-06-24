import 'package:cloth_collection/bloc/review_bloc/review_bloc.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/review_bloc/review_state.dart';

class CreateReview extends StatefulWidget {
  const CreateReview({Key? key}) : super(key: key);

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  static const moveTobackUrl = "assets/images/svg/moveToBack.svg";
  static const createReview = "리뷰 작성";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewBloc(),
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
                  moveTobackUrl,
                  width: 10 * Scale.width,
                  height: 20 * Scale.height,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(width: 14 * Scale.width),
              Text(createReview,
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 22.0)),
            ],
          ),
        ),
        body: ScrollArea(),
        bottomSheet: CreateCompleteButton(),
      ),
    );
  }
}

class CreateCompleteButton extends StatelessWidget {
  static const writeComplete = "작성 완료";

  const CreateCompleteButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 60 * Scale.height,
              color: MAINCOLOR,
              child: Center(
                child: Text(
                  writeComplete,
                  style: textStyle(
                      Colors.white, FontWeight.w500, "NotoSansKR", 17.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollArea extends StatefulWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 140 * Scale.height),
        child: Column(
          children: [
            ProductInfo(),
            divider(),
            StarArea(),
            divider(),
            ProductQuestionArea(),
            SizedBox(
              height: 30 * Scale.height,
            ),
            BodySizeArea(),
            divider(),
            TypingReviewArea(),
            AttachPhotoArea(),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
      child: Divider(
        thickness: 12 * Scale.height,
        color: Colors.grey[50],
      ),
    );
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20 * Scale.width),
          width: 74 * Scale.width,
          height: 74 * Scale.width * 4 / 3,
          // child: ClipRRect(
          //     borderRadius: BorderRadius.circular(8.0),
          //     child: CachedNetworkImage(
          //         fit: BoxFit.fill,
          //         imageUrl: item.option['product_image_url']
          //         ),),

          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
        ),
        SizedBox(
          width: 13 * Scale.width,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Product Name",
                style: textStyle(const Color(0xff333333), FontWeight.w500,
                    "NotoSansKR", 16.0),
              ),
              SizedBox(height: 4 * Scale.height),
              Text(
                "display_color_name / size | 수량 : count",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 13.0),
              ),
              SizedBox(height: 8 * Scale.height),
              Text(
                "x,xxx원",
                style: textStyle(const Color(0xff333333), FontWeight.w400,
                    "NotoSansKR", 15.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class StarArea extends StatelessWidget {
  static const questionString = "상품은 어떠셨나요?";
  const StarArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          questionString,
          style: textStyle(Colors.black, FontWeight.w700, 'NotoSansKR', 18.0),
        ),
      ],
    );
  }
}

class ProductQuestionArea extends StatelessWidget {
  static const sizeQuestion = "사이즈는 어떤가요?";
  static const colorQuestion = "색깔은 어떤가요?";
  static const qualityQuestion = "품질은 어떤가요";
  static const List<String> sizeOption = ["작아요", "딱 맞아요", "커요"];
  static const List<String> colorOption = ["어두워요", "화면과 같아요", "밝아요"];
  static const List<String> qualityOption = ["별로에요", "보통이에요", "좋아요"];
  const ProductQuestionArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sizeQuestion,
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 8 * Scale.height, bottom: 15 * Scale.height),
            child: Row(
              children: [
                sizeOptionButton(sizeOption[0]),
                SizedBox(width: 12 * Scale.width),
                sizeOptionButton(sizeOption[1]),
                SizedBox(width: 12 * Scale.width),
                sizeOptionButton(sizeOption[2]),
              ],
            ),
          ),
          Text(
            colorQuestion,
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 8 * Scale.height, bottom: 15 * Scale.height),
            child: Row(
              children: [
                colorOptionButton(colorOption[0]),
                SizedBox(width: 12 * Scale.width),
                colorOptionButton(colorOption[1]),
                SizedBox(width: 12 * Scale.width),
                colorOptionButton(colorOption[2]),
              ],
            ),
          ),
          Text(
            qualityQuestion,
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: 8 * Scale.height, bottom: 15 * Scale.height),
            child: Row(
              children: [
                qualityOptionButton(qualityOption[0]),
                SizedBox(width: 12 * Scale.width),
                qualityOptionButton(qualityOption[1]),
                SizedBox(width: 12 * Scale.width),
                qualityOptionButton(qualityOption[2]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sizeOptionButton(String option) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return InkWell(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * Scale.width, vertical: 10.0 * Scale.width),
              child: Text(
                option,
                style: textStyle(
                    state.selectedSizeOpinion == option
                        ? MAINCOLOR
                        : Colors.black,
                    FontWeight.w500,
                    'NotoSansKR',
                    15.0),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          onTap: () {
            context
                .read<ReviewBloc>()
                .add(ClickSizeOpinionEvent(content: option));
          },
        );
      },
    );
  }

  Widget colorOptionButton(String option) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return InkWell(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * Scale.width, vertical: 10.0 * Scale.width),
              child: Text(
                option,
                style: textStyle(
                    state.selectedColorOpinion == option
                        ? MAINCOLOR
                        : Colors.black,
                    FontWeight.w500,
                    'NotoSansKR',
                    15.0),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          onTap: () {
            context
                .read<ReviewBloc>()
                .add(ClickColorOpinionEvent(content: option));
          },
        );
      },
    );
  }

  Widget qualityOptionButton(String option) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return InkWell(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * Scale.width, vertical: 10.0 * Scale.width),
              child: Text(
                option,
                style: textStyle(
                    state.selectedQualityOpinion == option
                        ? MAINCOLOR
                        : Colors.black,
                    FontWeight.w500,
                    'NotoSansKR',
                    15.0),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          onTap: () {
            context
                .read<ReviewBloc>()
                .add(ClickQualityOpinionEvent(content: option));
          },
        );
      },
    );
  }
}

class BodySizeArea extends StatelessWidget {
  static const String commentString = "다른 유저들을 위해 체형을 입력해주세요.";
  const BodySizeArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            commentString,
            style: textStyle(Colors.black, FontWeight.w700, 'NotoSansKR', 18.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10 * Scale.height, horizontal: 20 * Scale.width),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: bodySizeBox('키'),
                ),
                SizedBox(
                  width: 20 * Scale.width,
                ),
                Expanded(
                  child: bodySizeBox('체중'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget bodySizeBox(String type) {
    final String select = "선택하기";
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0 * Scale.height),
        child: Column(
          children: [
            Text(
              type,
              style:
                  textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 14.0),
            ),
            SizedBox(
              height: 5 * Scale.height,
            ),
            Text(
              select,
              style: textStyle(Color.fromARGB(255, 152, 125, 233),
                  FontWeight.w500, 'NotoSansKR', 14.0),
            ),
          ],
        ),
      ),
    );
  }
}

class TypingReviewArea extends StatelessWidget {
  static const String commentString = "리뷰를 작성해주세요";
  static const String hintText =
      "텍스트 리뷰는 100p, 포토리뷰는 500p를 드려요! 최소 10자 이상 작성해주세요.";
  final TextEditingController _reviewController = TextEditingController();
  TypingReviewArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
                child: Text(
                  commentString,
                  style: textStyle(
                      Colors.black, FontWeight.w700, 'NotoSansKR', 19.0),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 400 * Scale.height,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[500]!),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: TextField(
                          controller: _reviewController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 1,
                          style: textStyle(Colors.black, FontWeight.w500,
                              'NotoSansKR', 14.0),
                          cursorColor: Colors.grey[500],
                          decoration: InputDecoration(
                            hintText: hintText,
                            hintStyle: textStyle(
                              Colors.grey[400]!,
                              FontWeight.w500,
                              'NotoSansKR',
                              14.0,
                            ),
                            hintMaxLines: 3,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5 * Scale.height),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${_reviewController.text.length} / 1,000자',
                    style: textStyle(
                        Colors.grey[400]!, FontWeight.w400, 'NotoSansKR', 14.0),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class AttachPhotoArea extends StatelessWidget {
  static const String commentString = "포토리뷰 사진 첨부";
  static const String commentString2 = "포토리뷰를 작성하면 500p를 드려요!";
  static const String commentString3 =
      "상품과 무관한 사진을 올리면 노출 제한 처리 및 포인트 회사 될 수 있습니다. 개인정보가 노출되지 않도록 유의해주세요.";
  const AttachPhotoArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentString,
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 19.0),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
                child: Text(
                  commentString2,
                  style: textStyle(
                      Colors.red, FontWeight.w400, 'NotoSansKR', 14.0),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 5,
                ),
                itemCount: state.pickedPhotoList.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10 * Scale.height,
                        ),
                        child: DottedBorder(
                          color: Colors.grey[500]!,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(7),
                          child: Padding(
                            padding: EdgeInsets.all(20 * Scale.width),
                            child: Center(
                              child: Container(
                                width: 60 * Scale.width,
                                height: 60 * Scale.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.camera_alt_outlined),
                                    Text(
                                      "${state.pickedPhotoList.length}/5",
                                      style: textStyle(Colors.grey[400]!,
                                          FontWeight.w400, 'NotoSansKR', 14.0),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        context.read<ReviewBloc>().add(ClickAddPhotoEvent());
                      },
                    );
                  } else {
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10 * Scale.height,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.grey[200],
                              child: Image.file(
                                state.pickedPhotoList[index - 1],
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 10,
                          child: InkWell(
                            child:
                                SvgPicture.asset('assets/images/svg/close.svg'),
                            onTap: () {
                              context
                                  .read<ReviewBloc>()
                                  .add(ClickRemovePhotoEvent(index: index - 1));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              Text(
                commentString3,
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w400, 'NotoSansKR', 13.0),
              ),
            ],
          ),
        );
      },
    );
  }
}
