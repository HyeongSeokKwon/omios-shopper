import 'package:cloth_collection/http/httpService.dart';
import 'package:cloth_collection/model/orderProduct.dart';
import 'package:cloth_collection/model/productDetailModel.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:get/get.dart';

class ProductDetailController extends GetxController {
  late ProductDetailInfo productInfo;

  int colorCount = 0;
  int sizeCount = 0;
  int totalPrice = 0;
  bool isColorButtonClicked = true;
  bool isSizeButtonClicked = false;

  int reviewTabIndex = 0;
  int selectedColorIndex = -1;
  int selectedSizeIndex = -1;
  HttpService httpservice = HttpService();

  var colorData = [];
  var sizeData = [];

  List<OrderProduct> productCart = [];
  double opacity = 0;

  void changeOffset(double pageControllerOffset) {
    double standard = 496 * Scale.height;
    if (pageControllerOffset > standard) {
      pageControllerOffset = standard;
    } else if (pageControllerOffset < 0) {
      pageControllerOffset = 0;
    }
    opacity = pageControllerOffset / standard;
    update();
  }

  void initController() {
    //selectColorArray = List.generate(colorData.length, (index) => false);
    colorCount = colorData.length;
  }

  Future<dynamic> getProductDetailInfo(int productId) async {
    try {
      var response = await httpservice.httpGet('/products/$productId');
      print(response);
      productInfo = ProductDetailInfo.fromJson(response['data']);
      for (Map color in productInfo.colors) {
        if (color['on_sale'] == true) {
          colorData.add(color);
        }
      }

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getRecommandProductInfo() async {
    Map<String, String> queryParams = {};
    queryParams['sub_category'] = "7";
    print("getRecommandProducts");
    var response =
        await httpservice.httpGet("/products", queryParams).catchError((e) {
      print(e);
      throw e;
    });
    print(response);
    return response['data']['results'];
  }

  void reviewTabClicked(int tab) {
    reviewTabIndex = tab;
    update(['review']);
  }

  void clickedColorButton() {
    if (isColorButtonClicked) {
      colorCount = 0;
    } else {
      colorCount = colorData.length;
    }
    isColorButtonClicked = !isColorButtonClicked;
    print(isColorButtonClicked);
    update();
  }

  void clickedSizeButton() {
    if (selectedColorIndex != -1) {
      if (isSizeButtonClicked) {
        sizeCount = 0;
      } else {
        sizeCount = sizeData.length;
      }
      isSizeButtonClicked = !isSizeButtonClicked;
      update();
    }
  }

  void selectColor(int index) {
    if (selectedColorIndex != index) {
      selectedColorIndex = index;
      colorCount = 0;
      sizeCount = sizeData.length;

      sizeData = List.generate(colorData[selectedColorIndex]['options'].length,
          (index) {
        if (colorData[selectedColorIndex]['options'][index]['on_sale'] ==
            true) {
          return colorData[selectedColorIndex]['options'][index]['size'];
        }
      });
      isColorButtonClicked = false;
    } else {
      selectedColorIndex = -1;
    }

    update();
  }

  void selectSize(int index) {
    if (selectedSizeIndex != index) {
      selectedSizeIndex = index;
      sizeCount = 0;
      isSizeButtonClicked = false;
    } else {
      selectedSizeIndex = -1;
    }

    update();
  }

  void pushProduct() {
    if (selectedSizeIndex != -1 && selectedColorIndex != -1) {
      OrderProduct orderProduct = OrderProduct(
        name: productInfo.name,
        imageUrl: productInfo.images[0]['image_url'],
        baseDiscountRate: productInfo.baseDiscountRate,
        color: colorData[selectedColorIndex],
        size: sizeData[selectedSizeIndex],
        count: 1,
        salePrice: productInfo.salePrice,
        baseDiscountedPrice: productInfo.baseDiscountedPrice,
        optionId: productInfo.colors[selectedColorIndex]['options']
            [selectedSizeIndex]['id'],
      );

      print(productInfo.colors[selectedColorIndex]['options'][selectedSizeIndex]
          ['id']);

      for (int i = 0; i < productCart.length; i++) {
        // 중복 상품 추가 있을때
        if (productCart[i].size == sizeData[selectedSizeIndex] &&
            productCart[i].color == colorData[selectedColorIndex]) {
          productCart[i].count++;
          totalPrice = totalPrice + orderProduct.salePrice;
          update();
          return;
        }
      }
      productCart.add(orderProduct);

      totalPrice = totalPrice + orderProduct.salePrice;
      selectedColorIndex = -1;
      selectedSizeIndex = -1;
      update();
    }
  }

  void popProduct(int index) {
    totalPrice =
        totalPrice - (productCart[index].salePrice * productCart[index].count);
    productCart.removeAt(index);
    update();
  }

  void addProductCount(int index) {
    productCart[index].count++;
    totalPrice = totalPrice + productCart[index].salePrice;
    update();
  }

  void substractProductCount(int index) {
    if (productCart[index].count != 1) {
      productCart[index].count--;
      totalPrice = totalPrice - productCart[index].salePrice;
    }
    update();
  }

  void getTotalPrice() {
    for (int i = 0; i < productCart.length; i++) {
      totalPrice =
          totalPrice + (productCart[i].count * productCart[i].salePrice);
    }

    update();
  }
}
