import 'package:cloth_collection/page/home.dart';
import 'package:cloth_collection/page/login/login.dart';
import 'package:cloth_collection/page/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white, // navigation bar color
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent, // status bar color
          statusBarIconBrightness: Brightness.dark),
    );
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const Splash(),
        '/login': (context) => const Login(),
        '/home': (context) => HomePage(),
      },
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!);
      },
    );
  }
}
