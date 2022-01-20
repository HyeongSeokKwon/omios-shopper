class Product {
  int id;
  int price;
  String name;
  String? mainImage;
  String defaultImage;

  Product(
      {required this.id,
      required this.price,
      required this.name,
      required this.mainImage,
      required this.defaultImage});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      price: json['price'],
      name: json['name'],
      mainImage: json['main_image'],
      defaultImage: json['default_image'],
    );
  }
}
