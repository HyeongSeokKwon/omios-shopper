import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/search_bloc/search_bloc.dart';
import 'package:cloth_collection/controller/categoryController.dart';
import 'package:cloth_collection/controller/searchBytTextController.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/category/categoryProductView.dart';
import 'package:cloth_collection/repository/categoryRepository.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  CategoryRepository categoryRepository = CategoryRepository();
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    //searchByTextController.streamController.add([]);
    // 첫 빌드시 검색 "" 초기화
    // if (widget.initialSearchText != null) {
    //   searchByTextController.isSearchButtonClicked = true;
    //   searchByTextController.getSearchResults(widget.initialSearchText!);
    //   textController.text = widget.initialSearchText!;
    // }
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
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    scrollController.dispose();
    searchByTextController.streamController.close();
    searchByTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
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
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return TextField(
                    controller: textController,
                    autofocus: false,
                    onChanged: (String value) {
                      context
                          .read<SearchBloc>()
                          .add(ChangeSearchingText(text: value));
                    },
                    onSubmitted: (String value) async {
                      if (value.length >= 2) {
                        searchByTextController.isSearchButtonClicked = true;
                        searchByTextController.getSearchResults(value);
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
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 1),
                        ),
                        hintText: ' 검색어를 입력하세요'),
                  );
                },
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (context.read<SearchBloc>().state.searchState ==
                    FetchState.success) {
                  return Padding(
                    padding: EdgeInsets.only(left: 8.0 * Scale.width),
                    child: Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: context
                              .read<SearchBloc>()
                              .state
                              .searchBoxList['main_category']
                              .length,
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
                                      context
                                              .read<SearchBloc>()
                                              .state
                                              .searchBoxList['main_category']
                                          [index]['name'],
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 17.0),
                                    ),
                                    Text(
                                      "  카테고리",
                                      style: textStyle(Colors.grey[400]!,
                                          FontWeight.w500, "NotoSansKR", 13.0),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                CategoryController categoryController =
                                    CategoryController();
                                categoryController.mainCategory = Category(
                                    id: context
                                            .read<SearchBloc>()
                                            .state
                                            .searchBoxList['main_category']
                                        [index]['id'],
                                    name: context
                                            .read<SearchBloc>()
                                            .state
                                            .searchBoxList['main_category']
                                        [index]['name']);
                                Get.to(CategoryProductView(categoryController));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: context
                              .read<SearchBloc>()
                              .state
                              .searchBoxList['sub_category']
                              .length,
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
                                      context
                                              .read<SearchBloc>()
                                              .state
                                              .searchBoxList['sub_category']
                                          [index]['name'],
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 17.0),
                                    ),
                                    Text(
                                      "  카테고리",
                                      style: textStyle(Colors.grey[400]!,
                                          FontWeight.w500, "NotoSansKR", 13.0),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () async {
                                Map mainCategory = await categoryRepository
                                    .getMainCategoryBySubCategoryId(context
                                            .read<SearchBloc>()
                                            .state
                                            .searchBoxList['sub_category']
                                        [index]['id']);
                                CategoryController categoryController =
                                    CategoryController();
                                categoryController.mainCategory = Category(
                                  id: mainCategory['id'],
                                  name: mainCategory['name'],
                                );

                                Get.to(CategoryProductView(
                                    categoryController,
                                    context
                                            .read<SearchBloc>()
                                            .state
                                            .searchBoxList['sub_category']
                                        [index]['id']));
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: context
                              .read<SearchBloc>()
                              .state
                              .searchBoxList['keyword']
                              .length,
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
                                        context
                                            .read<SearchBloc>()
                                            .state
                                            .searchBoxList['keyword'][index],
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
                                  // searchByTextController.getSearchResults(
                                  //     snapshot.data['keyword'][index]);
                                  // textController.text =
                                  //     snapshot.data['keyword'][index];
                                  // searchByTextController
                                  //     .isSearchButtonClicked = true;
                                });
                          },
                          separatorBuilder: (context, index) {
                            return Divider();
                          },
                        ),
                      ],
                    ),
                  );
                } else if (context.read<SearchBloc>().state.searchState ==
                    FetchState.loading) {
                  return progressBar();
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


// SingleChildScrollView(
//           child: StreamBuilder(
//             stream: searchByTextController.streamController.stream,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               return Container(
//                 child: GetBuilder<SearchByTextController>(
//                   init: searchByTextController,
//                   builder: (controller) {
//                     if (controller.isSearchButtonClicked) {
//                       if (snapshot.hasData) {
//                         print("has data");
//                         return GridView.builder(
//                           controller: scrollController,
//                           itemCount: snapshot.data.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.6,
//                           ),
//                           itemBuilder: (context, int index) {
//                             return ProductCard(
//                                 product: Product.fromJson(snapshot.data[index]),
//                                 imageWidth: 190 * Scale.width);
//                           },
//                         );
//                       } else {
//                         print("waiting");
//                         return progressBar();
//                       }
//                     } else {
//                       if (controller.searchText!.isEmpty) {
//                         return Text("검색어를 입력해주세요");
//                       }
//                       if (snapshot.hasData) {
//                         return Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 22 * Scale.width),
//                           child: Column(
//                             children: [
//                               ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: snapshot.data['sub_category'].length,
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     child: Container(
//                                       height: 45 * Scale.height,
//                                       width: 414 * Scale.width,
//                                       child: Row(
//                                         children: [
//                                           SizedBox(
//                                             width: 15 * Scale.width,
//                                             height: 15 * Scale.width,
//                                             child: SvgPicture.asset(
//                                               "assets/images/svg/search.svg",
//                                               fit: BoxFit.scaleDown,
//                                             ),
//                                           ),
//                                           SizedBox(width: 7 * Scale.width),
//                                           Text(
//                                             snapshot.data['main_category'][0]
//                                                 ['name'],
//                                             style: textStyle(
//                                                 Colors.black,
//                                                 FontWeight.w500,
//                                                 "NotoSansKR",
//                                                 17.0),
//                                           ),
//                                           Icon(
//                                             Icons.keyboard_arrow_right,
//                                             size: 20 * Scale.width,
//                                           ),
//                                           Text(
//                                             snapshot.data['sub_category'][index]
//                                                 ['name'],
//                                             style: textStyle(
//                                                 Colors.black,
//                                                 FontWeight.w500,
//                                                 "NotoSansKR",
//                                                 17.0),
//                                           ),
//                                           Text(
//                                             "  카테고리",
//                                             style: textStyle(
//                                                 Colors.grey[400]!,
//                                                 FontWeight.w500,
//                                                 "NotoSansKR",
//                                                 13.0),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: () {
//                                       CategoryController categoryController =
//                                           CategoryController();
//                                       categoryController.mainCategory =
//                                           Category(
//                                               id: snapshot.data['main_category']
//                                                   [0]['id'],
//                                               name:
//                                                   snapshot.data['main_category']
//                                                       [0]['name']);

//                                       Get.to(CategoryProductView(
//                                           categoryController,
//                                           snapshot.data['sub_category'][index]
//                                               ['id']));
//                                     },
//                                   );
//                                 },
//                                 separatorBuilder: (context, index) {
//                                   return Divider();
//                                 },
//                               ),
//                               Divider(),
//                               ListView.separated(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: snapshot.data['keyword'].length,
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                       child: Container(
//                                         height: 45 * Scale.height,
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                               width: 15 * Scale.width,
//                                               height: 15 * Scale.width,
//                                               child: SvgPicture.asset(
//                                                 "assets/images/svg/search.svg",
//                                                 fit: BoxFit.scaleDown,
//                                               ),
//                                             ),
//                                             SizedBox(width: 7 * Scale.width),
//                                             Text(
//                                               snapshot.data['keyword'][index],
//                                               style: textStyle(
//                                                   Colors.black,
//                                                   FontWeight.w500,
//                                                   "NotoSansKR",
//                                                   17.0),
//                                             ),
//                                             Text(
//                                               "  키워드",
//                                               style: textStyle(
//                                                   Colors.grey[400]!,
//                                                   FontWeight.w500,
//                                                   "NotoSansKR",
//                                                   13.0),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         searchByTextController.getSearchResults(
//                                             snapshot.data['keyword'][index]);
//                                         textController.text =
//                                             snapshot.data['keyword'][index];
//                                         searchByTextController
//                                             .isSearchButtonClicked = true;
//                                       });
//                                 },
//                                 separatorBuilder: (context, index) {
//                                   return Divider();
//                                 },
//                               ),
//                             ],
//                           ),
//                         );
//                       } else if (snapshot.hasError) {
//                         return ErrorWidget("");
//                       } else {
//                         return progressBar();
//                       }
//                     }
//                   },
//                 ),
//               );

//               //    else if (snapshot.hasError) {
//               //   return Container(child: Text("error"));
//               // } else if (snapshot.connectionState == ConnectionState.waiting) {
//               //   print("wating");
//               //   return Container(color: Colors.pink, child: progressBar());
//               // } else {
//               //   return Container(child: Text("검색어를 입력해주세요"));
//               // }
//             },
//           ),
//         ),