import 'package:cloth_collection/model/productModel.dart';

List<Map> temporaryProduct = [
  {
    'id': 1,
    'mainImage': "assets/images/임시상품1.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 26000,
    'defaultImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/default.png"
  },
  {
    'id': 2,
    'mainImage': "assets/images/임시상품2.png",
    'name': "텍스처 라운드 정장 자켓",
    'price': 26000,
    'defaultImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/default.png"
  },
  {
    'id': 2,
    'mainImage': "assets/images/임시상품3.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 8400,
    'defaultImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/default.png"
  },
  {
    'id': 4,
    'mainImage': "assets/images/임시상품4.png",
    'name': "머슬 분또 잠바",
    'price': 8400,
    'defaultImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/default.png"
  }
];
List<Product> getProduct() {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(Product(
        id: product['id'],
        mainImage: product['defaultImage'],
        name: product['name'],
        price: product['price'],
        defaultImage: product['defaultImage']));
  }
  return temporaryProductList;
}

Future<List<Product>> getProducts() async {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(
      Product(
          id: product['id'],
          mainImage: product['defaultImage'],
          name: product['name'],
          price: product['price'],
          defaultImage: product['defaultImage']),
    );
  }
  return temporaryProductList;
}
