import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ProductCard(),
      ),
    );
  }
}
