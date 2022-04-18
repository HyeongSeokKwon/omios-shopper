part of 'like_bloc.dart';

abstract class LikeEvent extends Equatable {
  const LikeEvent();

  @override
  List<Object> get props => [];
}

class ClickLikeButtonEvent extends LikeEvent {
  final String productId;

  ClickLikeButtonEvent({
    required this.productId,
  });
}
