class ProductDetailInfo {
  int id;
  String name;
  int price;
  List<dynamic> options;
  List<dynamic> images;
  Map<String, dynamic> subCategory;
  Map<String, dynamic> mainCategory;
  String defaultImage;

  ProductDetailInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.options,
    required this.images,
    required this.subCategory,
    required this.mainCategory,
    required this.defaultImage,
  });

  factory ProductDetailInfo.fromJson(Map<String, dynamic> json) {
    return ProductDetailInfo(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      options: json['options'],
      images: json['images'],
      subCategory: json['sub_category'],
      mainCategory: json['main_category'],
      defaultImage: json['default_image'],
    );
  }
}
