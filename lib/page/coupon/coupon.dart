import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/bloc/infinity_scroll_bloc/infinity_scroll_bloc.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../util/util.dart';

class Coupon extends StatefulWidget {
  const Coupon({Key? key}) : super(key: key);

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();
    CouponBloc couponBloc = CouponBloc(infinityScrollBloc);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => couponBloc,
        ),
        BlocProvider(
          create: (context) => infinityScrollBloc,
        ),
      ],
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
                "쿠폰",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 24.0),
              ),
            ],
          ),
          bottom: TabBar(
            controller: tabController,
            isScrollable: false,
            indicator: UnderlineTabIndicator(
              borderSide:
                  BorderSide(width: 2.0, color: const Color(0xffec5363)),
            ),
            tabs: [
              Container(
                width: 207 * Scale.width,
                child: Tab(
                  text: "보유 쿠폰",
                ),
              ),
              Container(
                width: 207 * Scale.width,
                child: Tab(
                  text: "쿠폰 받기",
                ),
              ),
            ],
            labelColor: const Color(0xffec5363),
            unselectedLabelColor: const Color(0xffcccccc),
            labelStyle: textStyle(
                Color(0xffec5363), FontWeight.w500, "NotoSansKR", 16.0),
            unselectedLabelStyle: textStyle(
                const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 16.0),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          titleSpacing: 0.0,
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            OwnCoupon(),
            GetCoupon(),
          ],
        ),
      ),
    );
  }
}

class OwnCoupon extends StatelessWidget {
  const OwnCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0 * Scale.width),
        child: Column(
          children: [percentCoupon()],
        ),
      ),
    );
  }

  Widget percentCoupon() {
    return Container(
      height: 170 * Scale.height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
        boxShadow: [
          BoxShadow(
              color: const Color(0x0f000000),
              offset: Offset(0, 10),
              blurRadius: 15,
              spreadRadius: 0)
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10 * Scale.width, vertical: 10 * Scale.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'XX%',
                    style: textStyle(
                        Colors.black, FontWeight.w700, 'NotoSansKR', 20.0),
                  ),
                  SizedBox(height: 10 * Scale.height),
                  Text(
                    '쿠폰 이름',
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                  ),
                  SizedBox(height: 10 * Scale.height),
                  Text(
                    'N원 이상 상품 구매 시 적용가능 최대 N원 할인',
                    style: textStyle(
                        Colors.grey[500]!, FontWeight.w400, 'NotoSansKR', 14.0),
                    maxLines: 3,
                  ),
                  Text(
                    'xxxx-xx-xx xx:xx까지',
                    style: textStyle(
                        Colors.grey[500]!, FontWeight.w400, 'NotoSansKR', 14.0),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            color: Colors.grey[300],
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/svg/arrowRight.svg',
                  width: 30 * Scale.width,
                  height: 30 * Scale.width,
                ),
                SizedBox(
                  height: 10 * Scale.height,
                ),
                Text(
                  '적용상품 보기',
                  style: textStyle(
                      Colors.grey[600]!, FontWeight.w400, 'NotoSansKR', 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget priceCoupon() {
    return Container();
  }
}

class GetCoupon extends StatefulWidget {
  GetCoupon({Key? key}) : super(key: key);

  @override
  State<GetCoupon> createState() => _GetCouponState();
}

class _GetCouponState extends State<GetCoupon> {
  final ScrollController scrollController = ScrollController();

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
        return BlocBuilder<CouponBloc, CouponState>(
          builder: (context, state) {
            print(state.canGetCouponState);
            if (state.canGetCouponState == ApiState.initial) {
              context.read<CouponBloc>().add(ShowCanGetCouponEvent());
              return progressBar();
            } else if (state.canGetCouponState == ApiState.success) {
              print(
                  context.read<InfinityScrollBloc>().state.targetDatas.length);
              return ListView.builder(
                controller: scrollController,
                itemCount:
                    context.read<InfinityScrollBloc>().state.targetDatas.length,
                itemBuilder: ((context, index) {
                  return percentCoupon(context
                      .read<InfinityScrollBloc>()
                      .state
                      .targetDatas[index]);
                }),
              );
            } else if (state.canGetCouponState == ApiState.fail) {
              return ErrorCard();
            } else {
              return progressBar();
            }
          },
        );
      },
    );
  }

  Widget percentCoupon(Map data) {
    DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 170 * Scale.height,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[300]!,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
          boxShadow: [
            BoxShadow(
                color: const Color(0x0f000000),
                offset: Offset(0, 10),
                blurRadius: 15,
                spreadRadius: 0)
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 10 * Scale.width, vertical: 10 * Scale.height),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['discount_rate'] != null
                          ? data['discount_rate'].toString() + "%"
                          : setPriceFormat(data['discount_price']) + "원",
                      style: textStyle(
                          Colors.black, FontWeight.w700, 'NotoSansKR', 20.0),
                    ),
                    SizedBox(height: 10 * Scale.height),
                    Text(
                      data['name'],
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                    ),
                    SizedBox(height: 10 * Scale.height),
                    Text(
                      'N원 이상 상품 구매 시 적용가능 최대 N원 할인',
                      style: textStyle(Colors.grey[500]!, FontWeight.w400,
                          'NotoSansKR', 14.0),
                      maxLines: 3,
                    ),
                    Text(
                      data['available_period'] != null
                          ? formatter.format(
                              DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day + data['available_period']
                                      as int,
                                  23,
                                  59,
                                  59),
                            )
                          : formatter.format(
                              (DateTime.parse(data['end_date'])).add(
                                Duration(hours: 23, minutes: 59, seconds: 59),
                              ),
                            ),
                      style: textStyle(Colors.grey[500]!, FontWeight.w400,
                          'NotoSansKR', 14.0),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1.0, color: Colors.grey[300]!),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        '쿠폰 받기',
                        style: textStyle(Colors.grey[600]!, FontWeight.w400,
                            'NotoSansKR', 14.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0 * Scale.height,
                    ),
                    child: DottedLine(
                      lineLength: 100,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/svg/arrowRight.svg',
                        width: 30 * Scale.width,
                        height: 30 * Scale.width,
                      ),
                      SizedBox(
                        height: 10 * Scale.height,
                      ),
                      Text(
                        '적용상품 보기',
                        style: textStyle(Colors.grey[600]!, FontWeight.w400,
                            'NotoSansKR', 14.0),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
