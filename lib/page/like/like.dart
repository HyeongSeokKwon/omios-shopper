import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/bloc/bloc.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:cloth_collection/widget/error_card.dart';
import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../model/productModel.dart';
import '../../util/util.dart';

class LikePage extends StatefulWidget {
  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeBloc(),
      child: scrollArea(),
    );
  }

  Widget scrollArea() {
    return BlocBuilder<LikeBloc, LikeState>(builder: (context, state) {
      if (state.getAllLikeState == ApiState.initial) {
        context.read<LikeBloc>().add(GetLikesProduct());
        return progressBar();
      } else if (state.getAllLikeState == ApiState.success) {
        return GridView.builder(
          itemCount: state.likeProducts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.6),
          itemBuilder: (context, int index) {
            return ProductCard(
                product: Product.fromJson(state.likeProducts[index]),
                imageWidth: 115);
          },
        );
      } else if (state.getAllLikeState == ApiState.fail) {
        return ErrorCard();
      } else {
        return progressBar();
      }
    });
  }
}
