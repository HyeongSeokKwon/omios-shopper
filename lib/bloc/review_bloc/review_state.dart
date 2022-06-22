import 'package:equatable/equatable.dart';

class ReviewState extends Equatable {
  final String selectedSizeOpinion;
  final String selectedColorOpinion;
  final String selectedQualityOpinion;
  final String createdReview;

  final List pickedPhotoList;

  ReviewState({
    required this.selectedSizeOpinion,
    required this.selectedColorOpinion,
    required this.selectedQualityOpinion,
    required this.createdReview,
    required this.pickedPhotoList,
  });

  factory ReviewState.initial() {
    return ReviewState(
      selectedSizeOpinion: '',
      selectedColorOpinion: '',
      selectedQualityOpinion: '',
      createdReview: '',
      pickedPhotoList: [],
    );
  }

  @override
  List<Object> get props {
    return [
      selectedSizeOpinion,
      selectedColorOpinion,
      selectedQualityOpinion,
      createdReview,
      pickedPhotoList,
    ];
  }

  ReviewState copyWith({
    String? selectedSizeOpinion,
    String? selectedColorOpinion,
    String? selectedQualityOpinion,
    String? createdReview,
    List? pickedPhotoList,
  }) {
    return ReviewState(
      selectedSizeOpinion: selectedSizeOpinion ?? this.selectedSizeOpinion,
      selectedColorOpinion: selectedColorOpinion ?? this.selectedColorOpinion,
      selectedQualityOpinion:
          selectedQualityOpinion ?? this.selectedQualityOpinion,
      createdReview: createdReview ?? this.createdReview,
      pickedPhotoList: pickedPhotoList ?? this.pickedPhotoList,
    );
  }
}
