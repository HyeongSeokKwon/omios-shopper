import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageController extends GetxController {
  Image? upLoadimage =
      Image.asset("assets/images/uploaded_picture/uploaded_picture.png");
  PickedFile? pickedFile;

  void getImageFromPhoto() async {
    pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile == null) {
      upLoadimage =
          Image.asset("assets/images/uploaded_picture/uploaded_picture.png");
    } else {
      upLoadimage = Image.file(
        File(pickedFile!.path),
      );
    }
    update();
  }

  void getImageFromGallery() async {
    pickedFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile == null) {
      upLoadimage = Image.asset(
        "assets/images/uploaded_picture/uploaded_picture.png",
      );
    } else {
      upLoadimage = Image.file(File(pickedFile!.path));
    }
    update();
  }

  void deleteImage() {
    upLoadimage =
        Image.asset("assets/images/uploaded_picture/uploaded_picture.png");

    update();
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
      upLoadimage = Image.file(File(croppedFile.path));
      update();
    }
  }
}
