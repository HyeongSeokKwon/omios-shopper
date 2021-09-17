class Product {
  String image;
  String name;
  String location;
  int price;

  Product(this.image, this.name, this.location, this.price);
}

List<Map> temporaryProduct = [
  {
    'image': "assets/images/임시상품1.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'location': "서울 중구 장충단로 263",
    'price': 26000
  },
  {
    'image': "assets/images/임시상품2.png",
    'name': "텍스처 라운드 정장 자켓",
    'location': "서울 중구 장충단로 263",
    'price': 26000
  },
  {
    'image': "assets/images/임시상품3.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'location': "서울 중구 장충단로 263",
    'price': 8400
  },
  {
    'image': "assets/images/임시상품4.png",
    'name': "머슬 분또 잠바",
    'location': "서울 중구 장충단로 263",
    'price': 8400
  }
];
List<Product> getProduct() {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(
      Product(
        product['image'],
        product['name'],
        product['location'],
        product['price'],
      ),
    );
  }
  return temporaryProductList;
}
