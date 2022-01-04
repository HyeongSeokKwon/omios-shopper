import 'package:cloth_collection/data/exampleProduct.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class CategoryProductView extends StatefulWidget {
  const CategoryProductView({Key? key}) : super(key: key);

  @override
  _CategoryProductViewState createState() => _CategoryProductViewState();
}

class _CategoryProductViewState extends State<CategoryProductView> {
  List<dynamic> colorList = [
    {"color": "블랙", "image": "assets/images/svg/black.svg"},
    {"color": "화이트", "image": "assets/images/svg/white.svg"},
    {"color": "브라운", "image": "assets/images/svg/brown.svg"},
    {"color": "베이지", "image": "assets/images/svg/beige.svg"},
    {"color": "남색", "image": "assets/images/svg/indigo.svg"},
    {"color": "네이비", "image": "assets/images/svg/navy.svg"},
    {"color": "옐로우", "image": "assets/images/svg/yellow.svg"},
    {"color": "레드", "image": "assets/images/svg/red.svg"},
    {"color": "초록", "image": "assets/images/svg/green.svg"},
    {"color": "블루", "image": "assets/images/svg/blue.svg"},
    {"color": "카키", "image": "assets/images/svg/khaki.svg"},
    {"color": "핑크", "image": "assets/images/svg/pink.svg"},
  ];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getCategoryList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Tab> tabs = [];
            for (int i = 0; i < snapshot.data.length; i++) {
              tabs.add(Tab(text: snapshot.data[i]));
            }
            return DefaultTabController(
              length: snapshot.data.length,
              child: Scaffold(
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
                      Text("Categoryname",
                          style: textStyle(const Color(0xff333333),
                              FontWeight.w700, "NotoSansKR", 22.0)),
                    ],
                  ),
                  actions: [
                    Padding(
                      padding: EdgeInsets.only(right: 22 * Scale.width),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Vibrate.feedback(VIBRATETYPE);
                              print(getCategoryList());
                            },
                            child: SvgPicture.asset(
                                "assets/images/svg/search.svg"),
                          ),
                          SizedBox(width: 22 * Scale.width),
                          GestureDetector(
                            onTap: () {
                              Vibrate.feedback(VIBRATETYPE);
                            },
                            child:
                                SvgPicture.asset("assets/images/svg/cart.svg"),
                          ),
                        ],
                      ),
                    ),
                  ],
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(100 * Scale.height),
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(width: 2.0),
                              insets: EdgeInsets.symmetric(horizontal: 16.0)),
                          tabs: tabs,
                          labelStyle: textStyle(const Color(0xff333333),
                              FontWeight.w400, "NotoSansKR", 16.0),
                          unselectedLabelStyle: textStyle(
                              const Color(0xffcccccc),
                              FontWeight.w400,
                              "NotoSansKR",
                              16.0),
                        ),
                        filterBarArea(),
                      ],
                    ),
                  ),
                ),
                body: Container(),
              ),
            );
          }
          return Container();
        });
  }

  Widget filterButton(String type) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(right: 8 * Scale.width),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(445)),
            border: Border.all(
              color: Color(0xffcccccc),
              width: 1,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10 * Scale.width, vertical: 6 * Scale.height),
            child: Row(
              children: [
                Text("$type ",
                    style: textStyle(const Color(0xff444444), FontWeight.w400,
                        "NotoSansKR", 14.0)),
                SvgPicture.asset(
                  "assets/images/svg/dropdown.svg",
                  width: 10 * Scale.width,
                  height: 5 * Scale.height,
                  fit: BoxFit.scaleDown,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          context: context,
          builder: (_) => DraggableScrollableSheet(
            expand: true,
            initialChildSize: 0.6,
            maxChildSize: 1.0,
            builder: (_, controller) {
              return optionArea();
            },
          ),
        );
      },
    );
  }

  Widget filterBarArea() {
    return Container(
      height: 52 * Scale.height,
      color: const Color(0xfffafafa),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 8 * Scale.width, left: 22 * Scale.width),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(445)),
                  border: Border.all(
                    color: Color(0xffcccccc),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 * Scale.width,
                    vertical: 6 * Scale.height,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/svg/refreshDark.svg",
                        width: 10 * Scale.width,
                        height: 10 * Scale.width,
                        fit: BoxFit.scaleDown,
                      ),
                      Text("  초기화",
                          style: textStyle(const Color(0xff444444),
                              FontWeight.w400, "NotoSansKR", 14.0))
                    ],
                  ),
                ),
              ),
            ),
            filterButton("추천순"),
            filterButton("색상"),
            filterButton("가격"),
            filterButton("연령"),
            filterButton("스타일"),
          ],
        ),
      ),
    );
  }

  Widget optionArea() {
    return Stack(children: [
      Container(
        width: 414 * Scale.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 24 * Scale.height),
          child: DefaultTabController(
            length: 4,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: "색상"),
                      Tab(text: "가격"),
                      Tab(text: "연령"),
                      Tab(text: "스타일"),
                    ],
                    labelPadding: EdgeInsets.only(right: 25 * Scale.width),
                    indicatorPadding: EdgeInsets.only(right: 25 * Scale.width),
                    isScrollable: true,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 2.0, color: const Color(0xffec5363)),
                    ),
                    labelStyle: textStyle(const Color(0xff333333),
                        FontWeight.w500, "NotoSansKR", 18.0),
                    unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w500, "NotoSansKR", 18.0),
                  ),
                  Expanded(
                    child: TabBarView(children: [
                      colorOptionArea(),
                      colorOptionArea(),
                      colorOptionArea(),
                      colorOptionArea(),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 15 * Scale.width,
        right: 15 * Scale.width,
        child: GestureDetector(
          child: SvgPicture.asset("assets/images/svg/close.svg",
              width: 22 * Scale.width,
              height: 22 * Scale.width,
              fit: BoxFit.scaleDown),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      )
    ]);
  }

  Widget colorOptionArea() {
    return Container(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 25 * Scale.height),
        itemCount: 12,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 30 * Scale.height,
            childAspectRatio: 0.8),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              SvgPicture.asset("${colorList[index]['image']}"),
              SizedBox(height: 4 * Scale.height),
              Text(
                "${colorList[index]['color']}",
                style: textStyle(const Color(0xff333333), FontWeight.w500,
                    "NotoSansKR", 16.0),
              )
            ],
          );
        },
      ),
    );
  }

  // Widget priceOptionArea() {
  //   return Expanded(
  //     child: GridView.builder(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: 20 * Scale.width, vertical: 25 * Scale.height),
  //       itemCount: 12,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 4,
  //           mainAxisSpacing: 30 * Scale.height,
  //           childAspectRatio: 0.8),
  //       itemBuilder: (BuildContext context, int index) {
  //         return SvgPicture.asset(colorList[index]);
  //       },
  //     ),
  //   );
  // }

  // Widget ageOptionArea() {
  //   return Expanded(
  //     child: GridView.builder(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: 20 * Scale.width, vertical: 25 * Scale.height),
  //       itemCount: 12,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 4,
  //           mainAxisSpacing: 30 * Scale.height,
  //           childAspectRatio: 0.8),
  //       itemBuilder: (BuildContext context, int index) {
  //         return SvgPicture.asset(colorList[index]);
  //       },
  //     ),
  //   );
  // }

  // Widget styleOptionArea() {
  //   return Expanded(
  //     child: GridView.builder(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: 20 * Scale.width, vertical: 25 * Scale.height),
  //       itemCount: 12,
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           crossAxisCount: 4,
  //           mainAxisSpacing: 30 * Scale.height,
  //           childAspectRatio: 0.8),
  //       itemBuilder: (BuildContext context, int index) {
  //         return SvgPicture.asset(colorList[index]);
  //       },
  //     ),
  //   );
  // }
}
