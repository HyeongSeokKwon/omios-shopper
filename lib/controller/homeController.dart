import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final int home = 0;
  final int category = 1;
  final int chat = 2;
  final int mypage = 3;
  List<String> currentIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg",
  ];
  List<String> navigationIconUrl = [
    "assets/images/svg/home.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg"
  ];
  List<String> navigationOnTapIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/categoryTapped.svg",
    "assets/images/svg/feedTapped.svg",
    "assets/images/svg/myPageTapped.svg"
  ];
  late ScrollController scrollController;

  int currentIndex = 0;

  void onItemTapped(int index) {
    print(index);
    if (currentIndex != index) {
      currentIconUrl[currentIndex] = navigationIconUrl[currentIndex];
      currentIndex = index;
      currentIconUrl[currentIndex] = navigationOnTapIconUrl[currentIndex];
    }
    if (index == home) {
      if (scrollController.hasClients) {
        scrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      }
    }
    update();
  }
}