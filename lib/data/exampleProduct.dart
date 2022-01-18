import 'package:cloth_collection/model/productModel.dart';

List<Map> temporaryProduct = [
  {
    'id': 1,
    'imageUrl': "assets/images/임시상품1.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 26000,
    'subCategory': 7,
    'wholeSaler': 9,
  },
  {
    'id': 2,
    'imageUrl': "assets/images/임시상품2.png",
    'name': "텍스처 라운드 정장 자켓",
    'price': 26000,
    'subCategory': 12,
    'wholeSaler': 4,
  },
  {
    'id': 2,
    'imageUrl': "assets/images/임시상품3.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'price': 8400,
    'subCategory': 2,
    'wholeSaler': 1,
  },
  {
    'id': 4,
    'imageUrl': "assets/images/임시상품4.png",
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
        name: product['name'],
        price: product['price'],
        subCategory: product['subCategory'],
        wholeSaler: product['wholesaler'],
      ),
    );
  }
  return temporaryProductList;
}
