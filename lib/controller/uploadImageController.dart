import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageController extends GetxController {
  File? upLoadimage;

  void getImageFromPhoto() async {
    final image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    upLoadimage = File(image!.path);
    update();
  }

  void getImageFromGallery() async {
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);

    upLoadimage = File(image!.path);
    update();
  }

  Future<Null> cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: upLoadimage!.path,
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
      upLoadimage = croppedFile;
      update();
    }
  }
}
