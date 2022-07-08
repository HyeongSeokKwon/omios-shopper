import 'package:cloth_collection/page/home.dart';
import 'package:flutter/material.dart';

import '../../../util/util.dart';

class FindPrivacy extends StatelessWidget {
  const FindPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _FindId(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
          child: SizedBox(
            height: 15 * Scale.height,
            child: const VerticalDivider(
              color: Color(0xff999999),
            ),
          ),
        ),
        const _FindPassword(),
      ],
    );
  }
}

class _FindId extends StatelessWidget {
  const _FindId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text("아이디 찾기",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }
}

class _FindPassword extends StatelessWidget {
  const _FindPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text("비밀번호 찾기",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {},
    );
  }
}
