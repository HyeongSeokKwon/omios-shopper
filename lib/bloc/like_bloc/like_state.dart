part of 'like_bloc.dart';

class LikeState extends Equatable {
  final ApiState getAllLikeState;
  final List likeProducts;

  LikeState({required this.getAllLikeState, required this.likeProducts});

  factory LikeState.initial([bool? initLike]) {
    return LikeState(
      getAllLikeState: ApiState.initial,
      likeProducts: [],
    );
  }

  @override
  List<Object> get props => [getAllLikeState, likeProducts];

  LikeState copyWith({
    bool? isLike,
    ApiState? getAllLikeState,
    List? likeProducts,
  }) {
    return LikeState(
        getAllLikeState: getAllLikeState ?? this.getAllLikeState,
        likeProducts: likeProducts ?? this.likeProducts);
  }
}
