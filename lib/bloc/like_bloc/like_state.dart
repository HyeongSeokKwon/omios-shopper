part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiState getAllLikeState;
  final ApiState postLikeState;
  final List likeProducts;

  LikeState(
      {required this.getAllLikeState,
      required this.postLikeState,
      required this.likeProducts});

  factory LikeState.initial([bool? initLike]) {
    return LikeState(
      getAllLikeState: ApiState.initial,
      postLikeState: ApiState.initial,
      likeProducts: [],
    );
  }

  @override
  List<Object> get props => [getAllLikeState, postLikeState, likeProducts];

  LikeState copyWith({
    bool? isLike,
    ApiState? postLikeState,
    ApiState? getAllLikeState,
    List? likeProducts,
  }) {
    return LikeState(
        getAllLikeState: getAllLikeState ?? this.getAllLikeState,
        postLikeState: postLikeState ?? this.postLikeState,
        likeProducts: likeProducts ?? this.likeProducts);
  }
}
