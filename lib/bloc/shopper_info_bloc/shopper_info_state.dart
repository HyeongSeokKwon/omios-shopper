part of 'shopper_info_bloc.dart';

class ShopperInfoState extends Equatable {
  final Map<String, dynamic> shopperInfo;
  final List pointHistory;
  final ApiState getShopperInfoState;
  final ApiState getPointHistoryState;

  ShopperInfoState({
    required this.shopperInfo,
    required this.pointHistory,
    required this.getShopperInfoState,
    required this.getPointHistoryState,
  });

  @override
  factory ShopperInfoState.initial() {
    return ShopperInfoState(
        shopperInfo: {},
        pointHistory: [],
        getShopperInfoState: ApiState.initial,
        getPointHistoryState: ApiState.initial);
  }

  @override
  List<Object> get props =>
      [shopperInfo, pointHistory, getShopperInfoState, getPointHistoryState];

  ShopperInfoState copyWith({
    Map<String, dynamic>? shopperInfo,
    List? pointHistory,
    ApiState? getShopperInfoState,
    ApiState? getPointHistoryState,
  }) {
    return ShopperInfoState(
      shopperInfo: shopperInfo ?? this.shopperInfo,
      pointHistory: pointHistory ?? this.pointHistory,
      getShopperInfoState: getShopperInfoState ?? this.getShopperInfoState,
      getPointHistoryState: getPointHistoryState ?? this.getPointHistoryState,
    );
  }
}
