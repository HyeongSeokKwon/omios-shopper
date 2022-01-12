class Product {
  int id;
  String imageUrl;
  String code;
  String name;
  int price;
  int subCategory;
  int wholeSaler;

  Product(
      {required this.id,
      required this.imageUrl,
      required this.code,
      required this.name,
      required this.price,
      required this.subCategory,
      required this.wholeSaler});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      imageUrl: "assets/images/임시상품2.png",
      code: json['code'],
      name: json['name'],
      price: json['price'],
      subCategory: json['sub_category'],
      wholeSaler: json['wholesaler'],
    );
  }
}
