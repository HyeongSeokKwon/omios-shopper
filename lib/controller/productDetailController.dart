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
    var response = await httpservice.httpGet('product/$productId');
    productInfo = ProductDetailInfo.fromJson(response['data']);

    for (Map i in productInfo.options) {
      if (!colorData.contains(i['color'])) {
        colorData.add(i['color']);
      }
    }
    for (Map i in productInfo.options) {
      if (!sizeData.contains(i['size'])) {
        sizeData.add(i['size']);
      }
    }

    print(colorData);
    print(sizeData);

    return response;
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
    if (isSizeButtonClicked) {
      sizeCount = 0;
    } else {
      sizeCount = sizeData.length;
    }
    isSizeButtonClicked = !isSizeButtonClicked;
    update();
  }

  void selectColor(int index) {
    if (selectedColorIndex != index) {
      selectedColorIndex = index;
      colorCount = 0;
      sizeCount = sizeData.length;
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
          color: colorData[selectedColorIndex],
          size: sizeData[selectedSizeIndex],
          count: 1,
          price: 10000);

      for (int i = 0; i < productCart.length; i++) {
        if (productCart[i].size == sizeData[selectedSizeIndex] &&
            productCart[i].color == colorData[selectedColorIndex]) {
          productCart[i].count++;
          totalPrice = totalPrice + orderProduct.price;
          update();
          return;
        }
      }
      productCart.add(orderProduct);

      totalPrice = totalPrice + orderProduct.price;
      selectedColorIndex = -1;
      selectedSizeIndex = -1;
      update();
    }
  }

  void popProduct(int index) {
    totalPrice =
        totalPrice - (productCart[index].price * productCart[index].count);
    productCart.removeAt(index);
    update();
  }

  void addProductCount(int index) {
    productCart[index].count++;
    totalPrice = totalPrice + productCart[index].price;
    update();
  }

  void substractProductCount(int index) {
    if (productCart[index].count != 1) {
      productCart[index].count--;
      totalPrice = totalPrice - productCart[index].price;
    }
    update();
  }

  void getTotalPrice() {
    for (int i = 0; i < productCart.length; i++) {
      totalPrice = totalPrice + (productCart[i].count * productCart[i].price);
    }

    update();
  }
}
