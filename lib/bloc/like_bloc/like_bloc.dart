import 'package:bloc/bloc.dart';
import 'package:cloth_collection/repository/userRepository.dart';
import 'package:equatable/equatable.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  UserRepository _userRepository = UserRepository();
  LikeBloc(bool initLike) : super(LikeState.initial(initLike)) {
    on<ClickLikeButtonEvent>(clickLikeButton);
  }

  Future<void> clickLikeButton(
      ClickLikeButtonEvent event, Emitter<LikeState> emit) async {
    if (state.isLike) {
      await unlikeRequest(event.productId);
      emit(state.copyWith(isLike: false));
      return;
    }

    await likeRequest(event.productId);

    emit(state.copyWith(isLike: true));
  }

  Future<void> likeRequest(String productId) async {
    Map response;
    response = await _userRepository.addLike(productId);
  }

  Future<void> unlikeRequest(String productId) async {
    Map response;
    response = await _userRepository.deleteLike(productId);
  }
}
