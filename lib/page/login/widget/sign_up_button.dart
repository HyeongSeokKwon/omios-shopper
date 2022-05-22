import 'package:cloth_collection/page/signUp/signUp.dart';
import 'package:flutter/material.dart';

import '../../../util/util.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * Scale.height),
      child: Center(
        child: TextButton(
          child: Text(
            "지금 회원가입하기!",
            style: textStyle(
                const Color(0xff666666), FontWeight.w500, "NotoSansKR", 16.0),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xffe2e2e2)),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 56 * Scale.height),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUp()));
          },
        ),
      ),
    );
  }
}
