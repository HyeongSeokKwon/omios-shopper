import 'dart:io';

import 'package:cloth_collection/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  PickedFile? _image;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: _image == null
                ? Text("선택된 이미지가 없습니다.")
                : Image.file(File(_image!.path)),
          ),
          FloatingActionButton(onPressed: getImageFromGallery)
        ],
      ),
    );
  }

  Future getImageFromGallery() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
