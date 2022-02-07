import 'package:cloth_collection/controller/searchBytTextController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchByText extends StatefulWidget {
  const SearchByText({Key? key}) : super(key: key);

  @override
  _SearchByTextState createState() => _SearchByTextState();
}

class _SearchByTextState extends State<SearchByText> {
  SearchByTextController searchByTextController = SearchByTextController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 첫 빌드시 검색 "" 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: textController,
          autofocus: true,
          onChanged: (String value) async {
            if (value.isNotEmpty) {
              await searchByTextController
                  .getSearchBoxResults(value); //글자 바뀔때마다 검색 요청
            }
          },
          onSubmitted: (String value) {
            setState(() {
              searchByTextController.isSearchButtonClicked = true;
            });
          },
          showCursor: false,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(11 * Scale.width),
              filled: true,
              fillColor: Colors.grey[5],
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(7)),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              hintText: ' 검색어를 입력하세요'),
        ),
      ),
      body: FutureBuilder(
        future: searchByTextController.getSearchBoxResults(
            ""), //controller의 searchData(list)를 future로 가지고 있는다. getBuilder로 감싸서 실시간 데이터 변화 감지
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GetBuilder<SearchByTextController>(
                init: searchByTextController,
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:
                              controller.searchBoxData['sub_category'].length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(controller.searchBoxData['sub_category']
                                    [index]['name']),
                              ],
                            );
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.searchBoxData['keyword'].length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Text(
                                    controller.searchBoxData['keyword'][index]),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Container(child: Text("error"));
          } else {
            return Container(child: Text("else"));
          }
        },
      ),
    );
  }

  Widget productArea(String text) {
    ScrollController scrollController = ScrollController();
    return SingleChildScrollView(
      child: FutureBuilder(
          future: searchByTextController.initGetProducts(text).catchError((e) {
            showAlertDialog(context, e);
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  child: GetBuilder<SearchByTextController>(
                      global: false,
                      init: searchByTextController,
                      builder: (controller) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5 * Scale.width),
                          child: Stack(
                            children: [
                              GridView.builder(
                                controller: scrollController,
                                itemCount: controller.searchData.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6,
                                ),
                                itemBuilder: (context, int index) {
                                  return ProductCard(
                                      product: Product.fromJson(
                                          controller.searchData[index]),
                                      imageWidth: 190 * Scale.width);
                                },
                              ),
                              Positioned(
                                bottom: 15 * Scale.width,
                                right: 15 * Scale.width,
                                child: GestureDetector(
                                  onTap: () {
                                    scrollController.jumpTo(
                                      0.0,
                                    );
                                  },
                                  child: Container(
                                      width: 45 * Scale.width,
                                      height: 45 * Scale.width,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(color: Colors.grey)
                                        ],
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                      child: Icon(Icons.arrow_upward_rounded)),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "네트워크에 연결하지 못했어요",
                        style: textStyle(
                            Colors.black, FontWeight.w700, "NotoSansKR", 20.0),
                      ),
                      Text(
                        "네트워크 연결상태를 확인하고",
                        style: textStyle(
                            Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                      ),
                      Text(
                        "다시 시도해 주세요",
                        style: textStyle(
                            Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                      ),
                      SizedBox(height: 15 * Scale.height),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadiusDirectional.all(
                                  Radius.circular(19))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 17 * Scale.width,
                                vertical: 14 * Scale.height),
                            child: Text("다시 시도하기",
                                style: textStyle(Colors.black, FontWeight.w700,
                                    'NotoSansKR', 15.0)),
                          ),
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                );
              }
            } else {
              return Container();
            }
          }),
    );
  }
}
