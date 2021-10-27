import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class UploadImageController extends GetxController {
  var uploadIcon = SvgPicture.asset("assets/images/svg/upload_picture.svg");
  var uploadImage;
  PickedFile? pickedFile;
  late List<int> imageBytes;

  void convert2BytesCode() async {
    imageBytes = await pickedFile!.readAsBytes();
    String base64Image = base64UrlEncode(imageBytes);
    print("바이트코드 => " + base64Image);
  }

  void getImageFromPhoto() async {
    pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      uploadImage = Image.file(
        File(pickedFile!.path),
      );
    }

    update();
  }

  void getImageFromGallery() async {
    pickedFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      uploadImage = Image.file(
        File(pickedFile!.path),
      );
    }
    update();
  }

  void deleteImage() {
    uploadImage = null;
    update();
  }

  bool isSelectedImage() {
    if (uploadImage == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<Null> cropImage() async {
  
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      uploadImage = SvgPicture.file(File(croppedFile.path));
      update();
    }
  }
}
