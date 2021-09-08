import 'dart:io';
import 'package:cloth_collection/controller/uploadImageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  final upLoadIcon = "assets/images/uploaded_picture/uploaded_picture.png";
  final id = "Deepy";
  final controller = Get.put(UploadImageController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xffffffff),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.045,
                  bottom: height * 0.025,
                  left: width * 0.053),
              child: Container(
                child: RichText(
                  text: TextSpan(
                    text: "$id님!\n",
                    style: TextStyle(
                        color: const Color(0xffec5363),
                        fontWeight: FontWeight.w700,
                        fontFamily: "NotoSansKR",
                        fontSize: 18.sp),
                    children: [
                      TextSpan(
                        text: "지금 어떤 옷을 찾고있나요?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSansKR",
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: InkWell(
                child: Container(
                  width: width * 0.894,
                  height: width * 0.894,
                  decoration: BoxDecoration(
                    color: const Color(0xfffafafa),
                    borderRadius: BorderRadius.all(Radius.circular(20.r)),
                  ),
                  child: GetBuilder<UploadImageController>(
                    builder: (_) => Center(
                      child: controller.upLoadimage == null
                          ? Center(
                              child: Image.asset(
                                "$upLoadIcon",
                                fit: BoxFit.fitHeight,
                              ),
                            )
                          : Image.file(
                              File(controller.upLoadimage!.path),
                              width: 370.w,
                              height: 370.w,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                ),
                onTap: () {
                  showPicker(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.029),
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
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: "NotoSansKR",
                            fontSize: 16.sp),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                        Size(width * 0.894, height * 0.067)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xffec5363)),
                  ),
                  onPressed: () {
                    showPicker(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                      controller.getImageFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    controller.getImageFromPhoto();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
