import 'package:cloth_collection/model/productModel.dart';

List<String> tempCatogoryList = ["플랫/로퍼", "힐/펌프스", "웨지힐", "샌들/슬리퍼", "스니커즈"];

Future<dynamic> getCategoryList() async {
  List list = tempCatogoryList;
  return tempCatogoryList;
}

List<Map> temporaryProduct = [
  {
    'id': 1,
    'imageUrl': "assets/images/임시상품1.png",
    'code': 'ke',
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 26000,
    'subCategory': 7,
    'wholeSaler': 9,
  },
  {
    'id': 2,
    'imageUrl': "assets/images/임시상품2.png",
    'code': 'kc',
    'name': "텍스처 라운드 정장 자켓",
    'price': 26000,
    'subCategory': 12,
    'wholeSaler': 4,
  },
  {
    'id': 2,
    'imageUrl': "assets/images/임시상품3.png",
    'code': 'ka',
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 8400,
    'subCategory': 2,
    'wholeSaler': 1,
  },
  {
    'id': 4,
    'imageUrl': "assets/images/임시상품4.png",
    'code': 'ky',
    'name': "머슬 분또 잠바",
    'price': 8400,
    'subCategory': 3,
    'wholeSaler': 1,
  }
];
List<Product> getProduct() {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(Product(
        id: product['id'],
        imageUrl: product['imageUrl'],
        code: product['code'],
        name: product['name'],
        price: product['price'],
        subCategory: product['subCategory'],
        wholeSaler: product['wholeSaler']));
  }
  return temporaryProductList;
}

Future<List<Product>> getProducts() async {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(
      Product(
        id: product['id'],
        imageUrl: product['image_url'],
        code: product['code'],
        name: product['name'],
        price: product['price'],
        subCategory: product['subCategory'],
        wholeSaler: product['wholesaler'],
      ),
    );
  }
  return temporaryProductList;
}
