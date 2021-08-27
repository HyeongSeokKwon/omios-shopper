import 'package:cloth_collection/page/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  loginTextField("ID"),
                  SizedBox(height: 20),
                  loginTextField("Password"),
                  SizedBox(
                    height: 10,
                  ),
                  Checkbox(
                      value: false,
                      onChanged: (value) {
                        isChecked = value!;
                        setState(() {});
                      })
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              child: Text("건너뛰기"),
              onTap: () {
                Get.to(HomePage(), transition: Transition.cupertino);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget loginTextField(String textType) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]!),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          style: TextStyle(fontSize: 25),
          decoration: InputDecoration(
            hintText: '$textType',
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }
}
