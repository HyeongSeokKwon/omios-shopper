import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class PointPage extends StatefulWidget {
  final int point;
  const PointPage({Key? key, required this.point}) : super(key: key);

  @override
  State<PointPage> createState() => _PointPageState();
}

class _PointPageState extends State<PointPage> {
  late TabController tabController;
  ScrollController scrollController = ScrollController();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopperInfoBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leadingWidth: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
              ),
              Text(
                "포인트",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
          builder: (context, state) {
            if (state.getPointHistoryState == ApiState.initial) {
              context
                  .read<ShopperInfoBloc>()
                  .add(GetPointHistoryEvent(type: 'All'));
              return progressBar();
            } else if (state.getPointHistoryState == ApiState.success) {
              return ScrollArea(point: widget.point);
            } else if (state.getPointHistoryState == ApiState.fail) {
              return ErrorCard();
            } else {
              return progressBar();
            }
          },
        ),
      ),
    );
  }
}

class ScrollArea extends StatefulWidget {
  final int point;
  const ScrollArea({Key? key, required this.point}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late final TabController tabController;
  late int selectedTab;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    selectedTab = 0;
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        context.read<ShopperInfoBloc>().add(PointPagenationEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return scrollArea();
  }

  Widget scrollArea() {
    List<Widget> tabBarViewList = [
      allPointTab(),
      getPointTab(),
      usedPointTab()
    ];
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0 * Scale.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "현재 포인트",
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 20.0),
                    ),
                    SizedBox(
                      height: 10 * Scale.height,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/images/svg/point.svg'),
                          SizedBox(
                            width: 10 * Scale.width,
                          ),
                          Text(
                            setPriceFormat(widget.point),
                            style: textStyle(Colors.black, FontWeight.w500,
                                'NotoSansKR', 20.0),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
            DefaultTabController(
              length: 3,
              child: StatefulBuilder(
                builder: ((context, setState) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TabBar(
                          tabs: [
                            Tab(
                              text: "전체",
                            ),
                            Tab(
                              text: "적립",
                            ),
                            Tab(
                              text: "사용",
                            ),
                          ],
                          onTap: (index) {
                            switch (index) {
                              case 0:
                                context
                                    .read<ShopperInfoBloc>()
                                    .add(GetPointHistoryEvent(type: 'All'));
                                break;
                              case 1:
                                context
                                    .read<ShopperInfoBloc>()
                                    .add(GetPointHistoryEvent(type: 'SAVE'));
                                break;
                              case 2:
                                context
                                    .read<ShopperInfoBloc>()
                                    .add(GetPointHistoryEvent(type: 'USE'));
                                break;
                              default:
                            }
                            // setState(() {
                            //   selectedTab = index;
                            // });
                          },
                          labelPadding:
                              EdgeInsets.only(right: 25 * Scale.width),
                          indicatorPadding:
                              EdgeInsets.only(right: 25 * Scale.width),
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                                width: 2.0, color: const Color(0xffec5363)),
                          ),
                          labelStyle: textStyle(const Color(0xff333333),
                              FontWeight.w500, "NotoSansKR", 18.0),
                          unselectedLabelStyle: textStyle(
                              const Color(0xffcccccc),
                              FontWeight.w500,
                              "NotoSansKR",
                              18.0),
                        ),
                        SizedBox(height: 15 * Scale.height),
                        tabBarViewList[selectedTab],
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pointTabBarView() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        allPointTab(),
        getPointTab(),
        usedPointTab(),
      ],
    );
  }

  Widget allPointTab() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.pointHistory.length,
          itemBuilder: ((context, index) {
            if (state.pointHistory[index]['point'] < 0) {
              return Column(
                children: [
                  usedPointBox(state.pointHistory[index]),
                  SizedBox(height: 10 * Scale.height),
                ],
              );
            } else {
              return Column(
                children: [
                  getPointBox(state.pointHistory[index]),
                  SizedBox(height: 10 * Scale.height),
                ],
              );
            }
          }),
        );
      },
    );
  }

  Widget getPointTab() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        List getPointList = [];
        for (Map value in state.pointHistory) {
          if (value['point'] > 0) {
            getPointList.add(value);
          }
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: getPointList.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                getPointBox(getPointList[index]),
                SizedBox(height: 10 * Scale.height),
              ],
            );
          }),
        );
      },
    );
  }

  Widget usedPointTab() {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        List usedPointList = [];
        for (Map value in state.pointHistory) {
          if (value['point'] < 0) {
            usedPointList.add(value);
          }
        }
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: usedPointList.length,
          itemBuilder: ((context, index) {
            return Column(
              children: [
                usedPointBox(usedPointList[index]),
                SizedBox(height: 10 * Scale.height),
              ],
            );
          }),
        );
      },
    );
  }

  Widget getPointBox(Map data) {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: 80 * Scale.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data['content'],
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                ),
                SizedBox(height: 5 * Scale.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "+" +
                          setPriceFormat(
                            data['point'],
                          ),
                      style: textStyle(Colors.blue[700]!, FontWeight.w500,
                          'NotoSansKR', 16.0),
                    ),
                    Text(data['created_at']),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget usedPointBox(Map data) {
    return BlocBuilder<ShopperInfoBloc, ShopperInfoState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[400]!),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          height: 80 * Scale.height,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(data['content']),
                SizedBox(height: 8 * Scale.height),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      setPriceFormat(data['point']),
                      style: textStyle(Colors.red[700]!, FontWeight.w500,
                          'NotoSansKR', 16.0),
                    ),
                    Text(data['created_at']),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
