class OrderHistoryData {
  int id;
  String number;
  Map<String, dynamic> shippingAddress;
  List<Item> items;
  DateTime createdAt;
  int shopper;

  OrderHistoryData({
    required this.id,
    required this.number,
    required this.shippingAddress,
    required this.items,
    required this.createdAt,
    required this.shopper,
  });

  factory OrderHistoryData.from(Map<String, dynamic> json) {
    return OrderHistoryData(
        id: json['id'],
        number: json['number'],
        shippingAddress: json['shipping_address'],
        items: List.generate(
            json['items'].length, (index) => Item.from(json['items'][index])),
        createdAt: DateTime.parse(json['created_at']),
        shopper: json['shopper']);
  }
}

class Item {
  int id;
  Map<String, dynamic> option;
  int baseDiscountPrice;
  int earnedPoint;
  int usedPoint;
  String status;
  int count;
  int salePrice;
  int membershipDiscountPrice;
  int paymentPrice;
  int? delivery;

  Item({
    required this.id,
    required this.option,
    required this.baseDiscountPrice,
    required this.earnedPoint,
    required this.usedPoint,
    required this.status,
    required this.count,
    required this.salePrice,
    required this.membershipDiscountPrice,
    required this.paymentPrice,
    required this.delivery,
  });

  factory Item.from(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      option: json['option'],
      baseDiscountPrice: json['base_discount_price'],
      earnedPoint: json['earned_point'],
      usedPoint: json['used_point'],
      status: json['status'],
      count: json['count'],
      salePrice: json['sale_price'],
      membershipDiscountPrice: json['membership_discount_price'],
      paymentPrice: json['payment_price'],
      delivery: json['delivery'],
    );
  }
}
