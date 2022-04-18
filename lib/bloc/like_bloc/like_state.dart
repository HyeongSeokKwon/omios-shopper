part of 'like_bloc.dart';

class LikeState extends Equatable {
  final bool isLike;

  LikeState({required this.isLike});

  factory LikeState.initial(bool initLike) {
    return LikeState(
      isLike: initLike,
    );
  }

  @override
  List<Object> get props => [isLike];

  LikeState copyWith({
    bool? isLike,
  }) {
    return LikeState(
      isLike: isLike ?? this.isLike,
    );
  }
}
