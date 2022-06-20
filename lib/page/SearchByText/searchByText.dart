import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/controller/categoryController.dart';
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
  TextEditingController textController = TextEditingController();

  FocusNode focusNode = FocusNode();

  InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();

  @override
  void dispose() {
    focusNode.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SearchBloc searchBloc = SearchBloc(infinityScrollBloc: infinityScrollBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider<InfinityScrollBloc>(
          create: (BuildContext context) => infinityScrollBloc,
        ),
        BlocProvider<SearchBloc>(
          create: (BuildContext context) => searchBloc,
        ),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(focusNode);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SvgPicture.asset(
                "assets/images/svg/moveToBack.svg",
                width: 10 * Scale.width,
                height: 20 * Scale.height,
                fit: BoxFit.scaleDown,
              ),
            ),
            titleSpacing: 0,
            title: GestureDetector(
              child: BlocBuilder<InfinityScrollBloc, InfinityScrollState>(
                builder: (context, state) {
                  return BlocBuilder<SearchBloc, SearchState>(
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
                            context
                                .read<SearchBloc>()
                                .add(ClickedSearchButtonEvent(text: value));
                          }
                        },
                        cursorColor: Colors.grey[400],
                        style: textStyle(Colors.grey[600]!, FontWeight.w500,
                            'NotoSansKR', 15.0),
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(11 * Scale.width),
                            filled: true,
                            fillColor: Colors.grey[5],
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: ' 검색어를 입력하세요',
                            hintStyle: textStyle(Colors.grey[600]!,
                                FontWeight.w500, 'NotoSansKR', 15.0)),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          body: SearchScrollArea(
            searchTextController: textController,
          ),
        ),
      ),
    );
  }
}

class SearchScrollArea extends StatefulWidget {
  final TextEditingController searchTextController;
  SearchScrollArea({Key? key, required this.searchTextController})
      : super(key: key);

  @override
  State<SearchScrollArea> createState() => _SearchScrollAreaState();
}

class _SearchScrollAreaState extends State<SearchScrollArea> {
  ScrollController scrollController = ScrollController();

  CategoryRepository categoryRepository = CategoryRepository();

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
    return BlocBuilder<InfinityScrollBloc, InfinityScrollState>(
      builder: (context, state) {
        return BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (context.read<SearchBloc>().state.searchState ==
                ApiState.success) {
              if (context.read<SearchBloc>().state.isClickedSearchingButton ==
                  true) {
                if (context.read<SearchBloc>().state.isClickedSearchingButton ==
                    true) {
                  return GridView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    itemCount: context
                        .read<InfinityScrollBloc>()
                        .state
                        .targetDatas
                        .length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, int index) {
                      return ProductCard(
                          product: Product.fromJson(context
                              .read<InfinityScrollBloc>()
                              .state
                              .targetDatas[index]),
                          imageWidth: 190 * Scale.width);
                    },
                  );
                } else if (context.read<InfinityScrollBloc>().state.getState ==
                    ApiState.loading) {
                  return Container(
                    child: Center(
                      child: progressBar(),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0 * Scale.width),
                    child: Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.zero,
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
                                height: 55 * Scale.height,
                                width: 414 * Scale.width,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0 * Scale.width),
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
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
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
                                height: 55 * Scale.height,
                                width: 414 * Scale.width,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0 * Scale.width),
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
                        ),
                        ListView.builder(
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
                                  height: 55 * Scale.height,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 8.0 * Scale.width),
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
                                ),
                                onTap: () {
                                  widget.searchTextController.text = context
                                      .read<SearchBloc>()
                                      .state
                                      .searchBoxList['keyword'][index];
                                  context.read<SearchBloc>().add(
                                      ClickedSearchButtonEvent(
                                          text: context
                                                  .read<SearchBloc>()
                                                  .state
                                                  .searchBoxList['keyword']
                                              [index]));
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (context.read<SearchBloc>().state.searchState ==
                ApiState.loading) {
              return progressBar();
            } else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
