class ProductDetailInfo {
  int id;
  String name;
  int price;
  bool lining;
  List<dynamic> materials;
  List<dynamic> colors;
  List<dynamic> images;
  String manufacturingCountry;
  Map<String, dynamic> mainCategory;
  Map<String, dynamic> subCategory;
  Map<String, dynamic> style;
  Map<String, dynamic> age;
  List<dynamic> tags;
  List<dynamic> laundryInformations;
  Map<String, dynamic> thickness;
  Map<String, dynamic> seeThrough;
  Map<String, dynamic> flexibility;
  Map<String, dynamic> theme;

  ProductDetailInfo({
    required this.id,
    required this.name,
    required this.price,
    required this.lining,
    required this.materials,
    required this.colors,
    required this.images,
    required this.manufacturingCountry,
    required this.mainCategory,
    required this.subCategory,
    required this.style,
    required this.age,
    required this.tags,
    required this.laundryInformations,
    required this.thickness,
    required this.seeThrough,
    required this.flexibility,
    required this.theme,
  });

  factory ProductDetailInfo.fromJson(Map<String, dynamic> json) {
    return ProductDetailInfo(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      lining: json['lining'],
      materials: json['materials'],
      colors: json['colors'],
      images: json['images'],
      manufacturingCountry: json['manufacturing_country'],
      mainCategory: json['main_category'],
      subCategory: json['sub_category'],
      style: json['style'],
      age: json['age'],
      tags: json['tags'],
      laundryInformations: json['laundry_informations'],
      thickness: json['thickness'],
      seeThrough: json['see_through'],
      flexibility: json['flexibility'],
      theme: json["theme"],
    );
  }
}
