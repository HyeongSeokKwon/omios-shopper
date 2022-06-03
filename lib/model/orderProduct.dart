class OrderProduct {
  String color;
  String size;
  String name;
  String imageUrl;

  int optionId;
  int baseDiscountedPrice;
  int baseDiscountRate;
  int count;
  int salePrice;

  OrderProduct({
    required this.color,
    required this.size,
    required this.name,
    required this.imageUrl,
    required this.optionId,
    required this.baseDiscountedPrice,
    required this.baseDiscountRate,
    required this.count,
    required this.salePrice,
  });
}
