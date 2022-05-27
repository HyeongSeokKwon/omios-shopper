part of 'shopper_info_bloc.dart';

abstract class ShopperInfoEvent extends Equatable {
  const ShopperInfoEvent();

  @override
  List<Object> get props => [];
}

class GetShopperInfoEvent extends ShopperInfoEvent {}

class GetPointHistoryEvent extends ShopperInfoEvent {}
