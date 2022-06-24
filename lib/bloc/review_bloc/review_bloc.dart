import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloth_collection/bloc/review_bloc/review_state.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'review_event.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewBloc() : super(ReviewState.initial()) {
    on<ClickSizeOpinionEvent>(clickSizeOpinion);
    on<ClickColorOpinionEvent>(clickColorOpinion);
    on<ClickQualityOpinionEvent>(clickQualityOpinion);
    on<ClickAddPhotoEvent>(addPhoto);
    on<ClickRemovePhotoEvent>(removePhoto);
  }

  void clickSizeOpinion(
      ClickSizeOpinionEvent event, Emitter<ReviewState> emit) {
    emit(state.copyWith(selectedSizeOpinion: event.content));
  }

  void clickColorOpinion(
      ClickColorOpinionEvent event, Emitter<ReviewState> emit) {
    emit(state.copyWith(selectedColorOpinion: event.content));
  }

  void clickQualityOpinion(
      ClickQualityOpinionEvent event, Emitter<ReviewState> emit) {
    emit(state.copyWith(selectedQualityOpinion: event.content));
  }

  void addPhoto(ClickAddPhotoEvent event, Emitter<ReviewState> emit) async {
    ImagePicker imagePicker = ImagePicker();
    List photoList = [...state.pickedPhotoList];

    if (photoList.length < 5) {
      List? photo = await imagePicker.pickMultiImage();
      if (photo != null) {
        for (var value in photo) {
          if (photoList.length < 5) {
            photoList.add(File(value.path));
          }
        }

        emit(state.copyWith(pickedPhotoList: photoList));
      }
    }
  }

  void removePhoto(ClickRemovePhotoEvent event, Emitter<ReviewState> emit) {
    List photoList = [...state.pickedPhotoList];
    photoList.removeAt(event.index);

    emit(state.copyWith(pickedPhotoList: photoList));
  }
}
