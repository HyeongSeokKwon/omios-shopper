import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

import '../page/login/login.dart';

class NeedLoginWidget extends StatefulWidget {
  final Widget routePage;
  NeedLoginWidget({Key? key, required this.routePage}) : super(key: key);

  @override
  State<NeedLoginWidget> createState() => _NeedLoginWidgetState();
}

class _NeedLoginWidgetState extends State<NeedLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "로그인이 필요한 서비스입니다.",
              style:
                  textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 18.0),
            ),
            SizedBox(
              height: 15 * Scale.height,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.all(Radius.circular(11))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15 * Scale.width,
                          vertical: 10 * Scale.height),
                      child: Center(
                        child: Text(
                          '로그인',
                          style: textStyle(Colors.grey[600]!, FontWeight.w500,
                              'NotoSansKR', 16.0),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login(
                                  routePage: widget.routePage,
                                )));
                  },
                ),
                SizedBox(width: 10 * Scale.width),
                Container(
                  decoration: BoxDecoration(
                      color: MAINCOLOR,
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15 * Scale.width,
                        vertical: 10 * Scale.height),
                    child: Center(
                      child: Text(
                        '회원가입',
                        style: textStyle(
                            Colors.white, FontWeight.w500, 'NotoSansKR', 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
