import 'package:cloth_collection/repository/httpRepository.dart';
import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  final int home = 0;
  final int category = 1;
  final int chat = 2;
  final int mypage = 3;

  HttpRepository httpRepository = HttpRepository();
  List<String> currentIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/bottomNavigationUnlike.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg",
  ];
  List<String> navigationIconUrl = [
    "assets/images/svg/home.svg",
    "assets/images/svg/category.svg",
    "assets/images/svg/bottomNavigationUnlike.svg",
    "assets/images/svg/feed.svg",
    "assets/images/svg/myPage.svg"
  ];
  List<String> navigationOnTapIconUrl = [
    "assets/images/svg/homeTapped.svg",
    "assets/images/svg/categoryTapped.svg",
    "assets/images/svg/bottomNavigationLike.svg",
    "assets/images/svg/feedTapped.svg",
    "assets/images/svg/myPageTapped.svg"
  ];

  int currentIndex = 0;

  void onItemTapped(int index) {
    if (currentIndex != index) {
      currentIconUrl[currentIndex] = navigationIconUrl[currentIndex];
      currentIndex = index;
      currentIconUrl[currentIndex] = navigationOnTapIconUrl[currentIndex];
    }
    update();
  }

  Future<dynamic> getTodaysProducts() async {
    Map<String, String> queryParams = {};
    queryParams['sub_category'] = "6";
    var response =
        await httpRepository.httpGet("/products", queryParams).catchError((e) {
      throw e;
    });
    print(response);
    print("getTodaysProducts");
    return response['data']['results'];
  }
}
