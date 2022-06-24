part of 'shopper_info_bloc.dart';

abstract class ShopperInfoEvent extends Equatable {
  const ShopperInfoEvent();

  @override
  List<Object> get props => [];
}

class GetShopperInfoEvent extends ShopperInfoEvent {}

class GetPointHistoryEvent extends ShopperInfoEvent {
  final String type;
  const GetPointHistoryEvent({
    required this.type,
  });
}

class PatchShopperInfoEvent extends ShopperInfoEvent {
  final String email;
  final String nickname;
  final String height;
  final String weight;

  const PatchShopperInfoEvent({
    required this.email,
    required this.nickname,
    required this.height,
    required this.weight,
  });
}

class PointPagenationEvent extends ShopperInfoEvent {}
