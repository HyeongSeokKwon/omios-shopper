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
    @override
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      color: const Color(0xffffffff),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMainText(width, height),
            _buildImageArea(width, height),
            ElevatedButton(
                onPressed: () {
                  controller.deleteImage();
                },
                child: Text("삭제")),
            _buildUploadButton(width, height),
          ],
        ),
      ),
    );
  }

  Widget _buildMainText(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.045, bottom: height * 0.025, left: width * 0.053),
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

  Widget _buildImageArea(double width, double height) {
    return Center(
      child: InkWell(
        child: Container(
          width: width * 0.894,
          height: height * 0.55,
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
          ),
          child: _buildOpenImage(width, height),
        ),
        onTap: () {
          showPicker(context);
        },
      ),
    );
  }

  Widget _buildUploadButton(double width, double height) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.029),
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
                  Size(width * 0.894, height * 0.067)),
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

  Widget _buildOpenImage(double width, double height) {
    return GetBuilder<UploadImageController>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: height * 0.3,
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
