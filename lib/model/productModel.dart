class Product {
  int id;
  int salePrice;
  String name;
  String? mainImage;

  Product({
    required this.id,
    required this.salePrice,
    required this.name,
    required this.mainImage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      salePrice: json['sale_price'],
      name: json['name'],
      mainImage: json['main_image'],
    );
  }
}
