import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget buildRatingBar(int size, double rating) {
  return RatingBarIndicator(
    rating: rating, // 상품 평점
    itemCount: 5,
    itemSize: size * Scale.width,
    itemBuilder: (context, index) => Icon(
      Icons.star,
      color: const Color(0xffffbe3f),
    ),
  );
}
