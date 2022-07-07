import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/repository/userRepository.dart';
import 'package:equatable/equatable.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  UserRepository _userRepository = UserRepository();
  LikeBloc() : super(LikeState.initial()) {
    on<ClickLikeButtonEvent>(clickLikeButton);
    on<GetLikesProduct>(getAllLikeProducts);
  }

  Future<void> clickLikeButton(
      ClickLikeButtonEvent event, Emitter<LikeState> emit) async {
    emit(state.copyWith(postLikeState: ApiState.initial));
    if (await _userRepository.isRefreshExpired()) {
      emit(state.copyWith(postLikeState: ApiState.unauthenticated));
      return;
    }
    if (event.isLike) {
      await likeRequest(event.productId);
      return;
    }

    await unlikeRequest(event.productId);
  }

  Future<void> likeRequest(String productId) async {
    Map response;

    response = await _userRepository.addLike(productId);
  }

  Future<void> unlikeRequest(String productId) async {
    Map response;
    response = await _userRepository.deleteLike(productId);
  }

  Future<void> getAllLikeProducts(
      GetLikesProduct event, Emitter<LikeState> emit) async {
    Map likeData;
    try {
      emit(state.copyWith(getAllLikeState: ApiState.loading));
      likeData = await _userRepository.getAllLikeProducts();
      emit(state.copyWith(
          getAllLikeState: ApiState.success,
          likeProducts: likeData['results']));
    } catch (e) {
      emit(state.copyWith(getAllLikeState: ApiState.fail));
    }
  }
}
