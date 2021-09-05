import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h, bottom: 15, left: 22.w),
            child: Container(
              child: Text(
                "Deepy님!\n지금 어떤 옷을 찾고있나요?",
                style: TextStyle(
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w700,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 23.0.sp),
              ),
            ),
          ),
          Center(
            child: InkWell(
              child: Container(
                width: 370.w,
                height: 370.w,
                decoration: BoxDecoration(
                  color: const Color(0xfffafafa),
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.r)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image == null
                        ? Center(
                            child: Image.asset(
                                "assets/images/uploaded_picture/uploaded_picture.png"),
                          )
                        : Image.file(
                            File(_image!.path),
                            width: 370.w,
                            height: 370.w,
                            fit: BoxFit.fitHeight,
                          ),
                  ],
                ),
              ),
              onTap: () {
                showPicker(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        "assets/images/upload_picture/upload_picture.png"),
                    SizedBox(width: 5.w),
                    Text(
                      "이미지 업로드",
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(Size(370.w, 60.h)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffec5363)),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future getImageFromPhoto() async {
    // ignore: invalid_use_of_visible_for_testing_member
    var image = await ImagePicker.platform
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromGallery() async {
    var image =
// ignore: invalid_use_of_visible_for_testing_member
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        )),
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        getImageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      getImageFromPhoto();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
