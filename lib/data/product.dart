class Product {
  String productCode;
  String image;
  String name;
  String store;
  String location;
  String category;
  String subCategory;
  int price;

  Product(this.productCode, this.image, this.name, this.store, this.location,
      this.price, this.category, this.subCategory);
}

List<Map> temporaryProduct = [
  {
    'productCode': 'kk',
    'image': "assets/images/임시상품1.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'store': "무신사 스토어",
    'location': "서울 중구 장충단로 263",
    'category': "상의",
    'subcategory': "티셔츠",
    'price': 26000
  },
  {
    'productCode': 'kc',
    'image': "assets/images/임시상품2.png",
    'name': "텍스처 라운드 정장 자켓",
    'store': "무신사 스토어",
    'location': "서울 중구 장충단로 263",
    'category': "상의",
    'subcategory': "아우터",
    'price': 26000
  },
  {
    'productCode': 'ka',
    'image': "assets/images/임시상품3.png",
    'name': "탄탄한 앤디 텍스처 라운드 숄더",
    'location': "서울 중구 장충단로 263",
    'store': "무신사 스토어",
    'category': "상의",
    'subcategory': "티셔츠",
    'price': 8400
  },
  {
    'productCode': 'ky',
    'image': "assets/images/임시상품4.png",
    'name': "머슬 분또 잠바",
    'location': "서울 중구 장충단로 263",
    'store': "무신사 스토어",
    'subcategory': "아우터",
    'category': "상의",
    'price': 8400
  }
];
List<Product> getProduct() {
  List<Product> temporaryProductList = [];
  for (var product in temporaryProduct) {
    temporaryProductList.add(
      Product(
        product['productCode'],
        product['image'],
        product['name'],
        product['store'],
        product['location'],
        product['price'],
        product['category'],
        product['subcategory'],
      ),
    );
  }
  return temporaryProductList;
}
