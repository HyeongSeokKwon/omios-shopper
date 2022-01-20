import 'dart:io';

import 'package:cloth_collection/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

dynamic showAlertDialog(BuildContext context, Exception e) {
  if (Platform.isIOS) {
    return CupertinoAlertDialog(
      content: Text("${e.toString()}"),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text("확인"),
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
