part of 'shopper_info_bloc.dart';

class ShopperInfoState extends Equatable {
  final Map<String, dynamic> shopperInfo;
  final List pointHistory;
  final ApiState getShopperInfoState;
  final ApiState patchShopperInfoState;
  final ApiState getPointHistoryState;

  const ShopperInfoState({
    required this.shopperInfo,
    required this.pointHistory,
    required this.getShopperInfoState,
    required this.patchShopperInfoState,
    required this.getPointHistoryState,
  });

  @override
  factory ShopperInfoState.initial() {
    return ShopperInfoState(
        shopperInfo: {},
        pointHistory: [],
        getShopperInfoState: ApiState.initial,
        patchShopperInfoState: ApiState.initial,
        getPointHistoryState: ApiState.initial);
  }

  @override
  List<Object> get props => [
        shopperInfo,
        pointHistory,
        getShopperInfoState,
        patchShopperInfoState,
        getPointHistoryState
      ];

  ShopperInfoState copyWith({
    Map<String, dynamic>? shopperInfo,
    List? pointHistory,
    ApiState? getShopperInfoState,
    ApiState? patchShopperInfoState,
    ApiState? getPointHistoryState,
  }) {
    return ShopperInfoState(
      shopperInfo: shopperInfo ?? this.shopperInfo,
      pointHistory: pointHistory ?? this.pointHistory,
      getShopperInfoState: getShopperInfoState ?? this.getShopperInfoState,
      patchShopperInfoState:
          patchShopperInfoState ?? this.patchShopperInfoState,
      getPointHistoryState: getPointHistoryState ?? this.getPointHistoryState,
    );
  }
}
