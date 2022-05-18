part of 'shopper_info_bloc.dart';

class ShopperInfoState extends Equatable {
  final Map<String, dynamic> shopperInfo;
  final ApiState getShopperInfoState;

  ShopperInfoState({
    required this.shopperInfo,
    required this.getShopperInfoState,
  });

  @override
  factory ShopperInfoState.initial() {
    return ShopperInfoState(
        shopperInfo: {}, getShopperInfoState: ApiState.initial);
  }

  @override
  List<Object> get props => [shopperInfo, getShopperInfoState];

  ShopperInfoState copyWith({
    Map<String, dynamic>? shopperInfo,
    ApiState? getShopperInfoState,
  }) {
    return ShopperInfoState(
      shopperInfo: shopperInfo ?? this.shopperInfo,
      getShopperInfoState: getShopperInfoState ?? this.getShopperInfoState,
    );
  }
}
