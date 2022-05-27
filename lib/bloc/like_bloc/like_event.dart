part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class ClickLikeButtonEvent extends LikeEvent {
  final String productId;
  final bool isLike;

  ClickLikeButtonEvent({
    required this.productId,
    required this.isLike,
  });
}

class GetLikesProduct extends LikeEvent {}
