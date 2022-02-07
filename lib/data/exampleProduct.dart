import 'package:cloth_collection/model/productModel.dart';

List<Map> temporaryProduct = [
  {
    'id': 1,
    'mainImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/sample/product_27.jpg",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 26000,
  },
  {
    'id': 2,
    'mainImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/sample/product_27.jpg",
    'name': "텍스처 라운드 정장 자켓",
    'price': 26000,
  },
  {
    'id': 2,
    'mainImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/sample/product_27.jpg",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 8400,
  },
  {
    'id': 4,
    'mainImage':
        "https://deepy.s3.ap-northeast-2.amazonaws.com/media/product/sample/product_27.jpg",
    'name': "머슬 분또 잠바",
    'price': 8400,
  }
];
List<Product> getProduct() {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(Product(
      id: product['id'],
      mainImage: product['mainImage'],
      name: product['name'],
      price: product['price'],
    ));
  }
  return temporaryProductList;
}

Future<List<Product>> getProducts() async {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(
      Product(
        id: product['id'],
        mainImage: product['mainImage'],
        name: product['name'],
        price: product['price'],
      ),
    );
  }
  return temporaryProductList;
}
