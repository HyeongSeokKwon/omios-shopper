import 'package:cloth_collection/controller/categoryController.dart';
import 'package:cloth_collection/controller/searchBytTextController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/category/categoryProductView.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchByText extends StatefulWidget {
  final String? initialSearchText;
  SearchByText([this.initialSearchText]);

  @override
  _SearchByTextState createState() => _SearchByTextState();
}

class _SearchByTextState extends State<SearchByText> {
  SearchByTextController searchByTextController = SearchByTextController();
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    searchByTextController.streamController.add([]);
    // 첫 빌드시 검색 "" 초기화
    if (widget.initialSearchText != null) {
      searchByTextController.isSearchButtonClicked = true;
      searchByTextController.getSearchResults(widget.initialSearchText!);
      textController.text = widget.initialSearchText!;
    }
    scrollController.addListener(() {
      print(scrollController.offset);
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          searchByTextController.nextDataLink != "") {
        searchByTextController.getProducts().catchError((e) {
          return showAlertDialog(context, e);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: GestureDetector(
            onTap: () {
              searchByTextController.isSearchButtonClicked = false;
            },
            child: TextField(
              controller: textController,
              autofocus: true,
              onChanged: (String value) async {
                searchByTextController.searchTextChange(value);
              },
              onSubmitted: (String value) {
                if (value.length >= 2) {
                  searchByTextController.getSearchResults(value);
                  searchByTextController.isSearchButtonClicked = true;
                }
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
        ),
        body: StreamBuilder(
          stream: searchByTextController.streamController.stream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GetBuilder<SearchByTextController>(
                init: searchByTextController,
                builder: (controller) {
                  if (controller.isSearchButtonClicked) {
                    return GridView.builder(
                      controller: scrollController,
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, int index) {
                        return ProductCard(
                            product: Product.fromJson(snapshot.data[index]),
                            imageWidth: 190 * Scale.width);
                      },
                    );
                  } else {
                    if (controller.searchText!.isEmpty) {
                      return Text("검색어를 입력해주세요");
                    }
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                      child: Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data['sub_category'].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: Container(
                                  height: 45 * Scale.height,
                                  width: 414 * Scale.width,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 15 * Scale.width,
                                        height: 15 * Scale.width,
                                        child: SvgPicture.asset(
                                          "assets/images/svg/search.svg",
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                      SizedBox(width: 7 * Scale.width),
                                      Text(
                                        snapshot.data['sub_category'][index]
                                            ['main_category']['name'],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            17.0),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 20 * Scale.width,
                                      ),
                                      Text(
                                        snapshot.data['sub_category'][index]
                                            ['name'],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            17.0),
                                      ),
                                      Text(
                                        "  카테고리",
                                        style: textStyle(
                                            Colors.grey[400]!,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            13.0),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  CategoryController categoryController =
                                      CategoryController();
                                  categoryController.mainCategory = Category(
                                      id: snapshot.data['sub_category'][index]
                                          ['main_category']['id'],
                                      name: snapshot.data['sub_category'][index]
                                          ['main_category']['name']);

                                  Get.to(CategoryProductView(
                                      categoryController,
                                      snapshot.data['sub_category'][index]
                                          ['id']));
                                },
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                          Divider(),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data['keyword'].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: Container(
                                    height: 45 * Scale.height,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 15 * Scale.width,
                                          height: 15 * Scale.width,
                                          child: SvgPicture.asset(
                                            "assets/images/svg/search.svg",
                                            fit: BoxFit.scaleDown,
                                          ),
                                        ),
                                        SizedBox(width: 7 * Scale.width),
                                        Text(
                                          snapshot.data['keyword'][index],
                                          style: textStyle(
                                              Colors.black,
                                              FontWeight.w500,
                                              "NotoSansKR",
                                              17.0),
                                        ),
                                        Text(
                                          "  키워드",
                                          style: textStyle(
                                              Colors.grey[400]!,
                                              FontWeight.w500,
                                              "NotoSansKR",
                                              13.0),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    searchByTextController.getSearchResults(
                                        snapshot.data['keyword'][index]);
                                    textController.text =
                                        snapshot.data['keyword'][index];
                                    searchByTextController
                                        .isSearchButtonClicked = true;
                                  });
                            },
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Container(child: Text("error"));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              print("wating");
              return Container(color: Colors.pink, child: progressBar());
            } else {
              return Container(child: Text("검색어를 입력해주세요"));
            }
          },
        ),
      ),
    );
  }
}
