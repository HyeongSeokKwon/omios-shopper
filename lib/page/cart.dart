import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: DefaultTabController(
        length: 2,
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
                Text("장바구니",
                    style: textStyle(const Color(0xff333333), FontWeight.w700,
                        "NotoSansKR", 22.0)),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(50 * Scale.height),
              child: Column(
                children: [
                  TabBar(
                    isScrollable: false,
                    indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 2.0, color: const Color(0xffec5363)),
                    ),
                    tabs: [
                      Container(
                        width: 207 * Scale.width,
                        child: Tab(
                          text: "0원배송",
                        ),
                      ),
                      Container(
                        width: 207 * Scale.width,
                        child: Tab(
                          text: "즉시배송",
                        ),
                      ),
                    ],
                    labelColor: const Color(0xffec5363),
                    unselectedLabelColor: const Color(0xffcccccc),
                    labelStyle: textStyle(
                        Color(0xffec5363), FontWeight.w500, "NotoSansKR", 16.0),
                    unselectedLabelStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: scrollArea(),
          ),
        ),
      ),
    );
  }

  Widget scrollArea() {
    return Column(
      children: [
        productInCartArea(),
      ],
    );
  }

  Widget productInCartArea() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 22 * Scale.width, vertical: 20 * Scale.height),
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/images/svg/cartUnCheck.svg"),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14.0),
                        child: Image.asset("assets/images/임시상품3.png",
                            width: 90 * Scale.width,
                            height: 90 * 1.2 * Scale.width),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(maxWidth: 200 * Scale.width),
                          child: Text("상품 이름 상품 이름 상품 이름 상품 이름 상품 이름 상품 이름 ",
                              style: textStyle(const Color(0xff333333),
                                  FontWeight.w400, "NotoSansKR", 16.0),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis),
                        ),
                        SizedBox(
                          height: 4 * Scale.height,
                        ),
                        Text("가격",
                            style: textStyle(const Color(0xff333333),
                                FontWeight.w500, "NotoSansKR", 17.0)),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14 * Scale.height),
                  child: Container(
                    width: 338 * Scale.width,
                    height: 46 * Scale.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: const Color(0xfffafafa),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 12 * Scale.width),
                        Text(
                          "옵션 : 다크그레이 / FREE",
                          style: textStyle(Color(0xff797979), FontWeight.w500,
                              "NotoSansKR", 14.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset("assets/images/svg/cartMinus.svg",
                              width: 22 * Scale.width,
                              height: 22 * Scale.height,
                              fit: BoxFit.scaleDown),
                          Text("3",
                              style: textStyle(const Color(0xff444444),
                                  FontWeight.w600, "NotoSansKR", 16.0)),
                          SvgPicture.asset("assets/images/svg/cartPlus.svg",
                              width: 22 * Scale.width,
                              height: 22 * Scale.height,
                              fit: BoxFit.scaleDown),
                        ],
                      ),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: const Color(0xffe2e2e2),
                            ),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(166 * Scale.width, 52 * Scale.height)),
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(width: 6 * Scale.width),
                    TextButton(
                      child: Text("0원 배송",
                          style: textStyle(const Color(0xffffffff),
                              FontWeight.w500, "NotoSansKR", 16.0)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        fixedSize: MaterialStateProperty.all<Size>(
                            Size(166 * Scale.width, 52 * Scale.height)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffec5363)),
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Icon(
              Icons.clear,
              color: const Color(0xffcccccc),
              size: 20.0 * Scale.width,
            ),
          )
        ],
      ),
    );
  }
}
