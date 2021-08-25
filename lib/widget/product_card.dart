import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 110,
            height: 110,
            color: Colors.red,
          ),
          Container(
            width: 110,
            height: 50,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}
