class Product {
  int id;
  int salePrice;
  int discountedPrice;
  String name;
  String? mainImage;
  bool isLike;
  Product({
    required this.id,
    required this.salePrice,
    required this.discountedPrice,
    required this.name,
    required this.mainImage,
    required this.isLike,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        salePrice: json['sale_price'],
        discountedPrice: json['base_discounted_price'],
        name: json['name'],
        mainImage: json['main_image'],
        isLike: json['shopper_like']);
  }
}
