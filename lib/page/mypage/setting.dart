import 'package:cloth_collection/page/mypage/patchUserInfo.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';

class Setting extends StatelessWidget {
  final ShopperInfoBloc shopperInfoBloc;
  Setting({Key? key, required this.shopperInfoBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Text("설정",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 22.0)),
          ],
        ),
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20 * Scale.width),
      child: Column(
        children: [
          SizedBox(height: 10 * Scale.height),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => PatchUserInfo(
                            shopperInfoBloc: shopperInfoBloc,
                          ))));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '회원정보 수정',
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
                ),
                SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
              ],
            ),
          ),
          SizedBox(height: 20 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '회원 탈퇴하기',
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 17.0),
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          ),
        ],
      ),
    );
  }
}
