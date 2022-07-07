import 'dart:io';

import 'package:cloth_collection/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../page/login/login.dart';

Widget progressBar() {
  if (Platform.isIOS) {
    return Center(child: CupertinoActivityIndicator());
  } else {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.pink[400]!,
        ),
      ),
    );
  }
}

dynamic showAlertDialog(BuildContext context, String e) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      content: Text("${e.toString()}"),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("확인"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            e.toString(),
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "확인",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

dynamic loginAlertDialog(BuildContext context, Widget routePage) {
  showDialog(
      context: context,
      builder: (context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            content: Text("로그인이 필요한 서비스입니다.",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0)),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("확인"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                routePage: routePage,
                              )));
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text("취소"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            content: Text("로그인이 필요한 서비스입니다.",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0)),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "확인",
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Login(
                                routePage: routePage,
                              )));
                },
              ),
              TextButton(
                child: Text(
                  "취소",
                  style: textStyle(
                      Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      });
}
