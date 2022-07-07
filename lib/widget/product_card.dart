import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/model/productModel.dart';
import 'package:cloth_collection/page/home.dart';
import 'package:cloth_collection/page/productDetail/productDetail.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:cloth_collection/widget/cupertinoAndmateritalWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import '../bloc/bloc.dart';
import '../page/login/login.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double imageWidth;

  ProductCard({required this.product, required this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LikeBloc(),
      child: GestureDetector(
        onTap: () {
          Vibrate.feedback(VIBRATETYPE);

          Get.to(() => ProductDetail(productId: product.id));
        },
        child: Container(
          child: Column(
            children: [
              _buildProductImage(),
              _buildProductInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    bool isLike = product.isLike;
    return Stack(
      children: [
        Container(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                width: imageWidth,
                height: imageWidth * (4 / 3),
                fit: BoxFit.fill,
                imageUrl: "${product.mainImage}",
                fadeInDuration: Duration(milliseconds: 0),
                placeholder: (context, url) {
                  return Container(
                      color: Colors.grey[200],
                      width: imageWidth,
                      height: imageWidth * (4 / 3));
                },
              )),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
            ),
          ),
        ),
        Positioned(
          child: BlocConsumer<LikeBloc, LikeState>(
            listener: (context, state) {
              if (state.postLikeState == ApiState.unauthenticated) {
                loginAlertDialog(context, HomePage());
              }
            },
            builder: (context, state) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return InkWell(
                    onTap: () {
                      setState(
                        () {
                          isLike = !isLike;
                        },
                      );
                      context.read<LikeBloc>().add(ClickLikeButtonEvent(
                          productId: product.id.toString(), isLike: isLike));
                    },
                    child: isLike
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                  );
                },
              );
            },
          ),
          bottom: 6 * Scale.width,
          right: 6 * Scale.height,
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Container(
      width: imageWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12 * Scale.height),
          Text(
            "${product.name}",
            style: textStyle(
                const Color(0xff999999), FontWeight.w400, "NotoSansKR", 12.0),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4 * Scale.height),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${setPriceFormat(product.discountedPrice)}원",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    'NotoSansKR', 14.0),
              ),
              // product.salePrice != product.discountedPrice
              //     ? Padding(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 4 * Scale.width),
              //         child: Text(
              //           "${setPriceFormat(product.salePrice)}원",
              //           style: TextStyle(
              //               color: const Color(0xff333333),
              //               fontWeight: FontWeight.w500,
              //               fontFamily: "NotoSansKR",
              //               fontSize: 14.0,
              //               decoration: TextDecoration.lineThrough),
              //         ),
              //       )
              //     : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
