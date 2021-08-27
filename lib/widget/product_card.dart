import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 0.27,
            height: height * 0.15,
            color: Colors.red,
          ),
          Container(
            width: width * 0.27,
            height: height * 0.08,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
