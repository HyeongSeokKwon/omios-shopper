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
    var base64Image = base64Encode(imageBytes);
    print("바이트코드 => " + base64Image);
  }

  void getImageFromPhoto() async {
    // ignore: invalid_use_of_visible_for_testing_member
    pickedFile = await ImagePicker.platform.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      uploadImage = Image.file(
        File(pickedFile!.path),
      );
    }

    print(pickedFile.runtimeType);
    convert2BytesCode();
    update();
  }

  void getImageFromGallery() async {
    print(22);
    // ignore: invalid_use_of_visible_for_testing_member
    pickedFile = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      uploadImage = Image.file(
        File(pickedFile!.path),
      );
    }
    print(pickedFile.runtimeType);
    update();
  }

  void deleteImage() {
    uploadImage = null;
    pickedFile = null;
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
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile!.path,
        // aspectRatioPresets: Platform.isAndroid
        //     ? [
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio16x9
        //       ]
        //     : [
        //         CropAspectRatioPreset.original,
        //         CropAspectRatioPreset.square,
        //         CropAspectRatioPreset.ratio3x2,
        //         CropAspectRatioPreset.ratio4x3,
        //         CropAspectRatioPreset.ratio5x3,
        //         CropAspectRatioPreset.ratio5x4,
        //         CropAspectRatioPreset.ratio7x5,
        //         CropAspectRatioPreset.ratio16x9
        //       ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: null,
          toolbarColor: Colors.transparent,
          //statusBarColor: Colors.transparent,
          toolbarWidgetColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          activeControlsWidgetColor: Colors.transparent,
          dimmedLayerColor: Colors.transparent,
          cropFrameColor: Colors.transparent,
          cropGridColor: Colors.transparent,
          // cropFrameStrokeWidth,
          // cropGridRowCount,
          // cropGridColumnCount,
          // cropGridStrokeWidth,
          // showCropGrid,
          // lockAspectRatio,
          hideBottomControls: true,
          // initAspectRatio}),
          // iosUiSettings: IOSUiSettings(
          //   title: 'Cropper',
          // ),
        ),
      );
      if (croppedFile != null) {
        uploadImage = Image.file(File(croppedFile.path));
        update();
      }
    }
  }
}
