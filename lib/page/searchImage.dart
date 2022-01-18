import 'package:cloth_collection/controller/uploadImageController.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchImage extends StatefulWidget {
  @override
  _SearchImageState createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  final upLoadIcon = "assets/images/svg/upload_picture.svg";
  final upLoadButtonIcon = "assets/images/svg/cloud_computing.svg";
  final id = "Deepy";
  final controller = Get.put(UploadImageController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xffffffff),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainText(),
            _buildImageArea(),
            ElevatedButton(
                onPressed: () {
                  controller.deleteImage();
                },
                child: Text("삭제")),
            _buildUploadButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainText() {
    return Padding(
      padding: EdgeInsets.only(
          top: 40 * Scale.height, bottom: 22 * Scale.height, left: 22 * 0.053),
      child: Container(
        child: RichText(
          text: TextSpan(
            text: "$id님!\n",
            style: textStyle(
                const Color(0xffec5363), FontWeight.w700, "NotoSansKR", 18.sp),
            children: [
              TextSpan(
                text: "지금 어떤 옷을 찾고있나요?",
                style: textStyle(
                    Colors.black, FontWeight.w500, "NotoSansKR", 18.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageArea() {
    return Center(
      child: InkWell(
        child: Container(
          width: 370 * Scale.width,
          height: 492 * Scale.height,
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: _buildOpenImage(),
        ),
        onTap: () {
          showPicker(context);
        },
      ),
    );
  }

  Widget _buildUploadButton() {
    return Padding(
      padding: EdgeInsets.only(top: 26 * Scale.height),
      child: Center(
        child: GetBuilder<UploadImageController>(
          builder: (_) => TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("$upLoadButtonIcon"),
                SizedBox(width: 5.w),
                Text(
                  controller.isSelectedImage() == false ? "이미지 업로드" : "검색하기",
                  style: textStyle(
                      Colors.white, FontWeight.w500, "NotoSansKR", 16.sp),
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
                  Size(370 * Scale.width, 60 * Scale.height)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffec5363)),
            ),
            onPressed: () {
              if (!controller.isSelectedImage()) {
                showPicker(context);
              } else {
                controller.convert2BytesCode();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOpenImage() {
    return GetBuilder<UploadImageController>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 268 * Scale.height,
              child: controller.isSelectedImage() == false
                  ? controller.uploadIcon
                  : controller.uploadImage,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.cropImage();
              },
              child: Text("자르기")),
        ],
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
