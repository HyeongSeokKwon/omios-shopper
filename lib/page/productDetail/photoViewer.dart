import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewer extends StatefulWidget {
  final List<dynamic> imageList;
  final int index;
  PhotoViewer({required this.imageList, required this.index});

  @override
  State<PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  late int curIndex;
  late PageController _pageController;
  PhotoViewScaleStateController scaleController =
      PhotoViewScaleStateController();
  late ScrollPhysics scrollPhysics = ClampingScrollPhysics();
  @override
  void initState() {
    super.initState();
    curIndex = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: widget.index);
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              child: PhotoViewGallery.builder(
                scrollPhysics: scrollPhysics,
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    scaleStateController: scaleController,
                    imageProvider: CachedNetworkImageProvider(
                        "${widget.imageList[index]['url']}"),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 1.75,
                  );
                },
                scaleStateChangedCallback: (controller) {
                  if (scaleController.isZooming) {
                    scrollPhysics = NeverScrollableScrollPhysics();
                    setState(() {});
                  } else {
                    scrollPhysics = ClampingScrollPhysics();
                    setState(() {});
                  }
                },
                itemCount: widget.imageList.length,
                pageController: _pageController,
                onPageChanged: (value) {
                  curIndex = value;
                  setState(() {});
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    top: 20 * Scale.height, right: 20 * Scale.height),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 20 * Scale.height),
                child: Container(
                  width: 414 * Scale.width,
                  child: Center(
                    child: Text(
                      "${(curIndex + 1).toInt()} / ${widget.imageList.length}",
                      style: textStyle(const Color(0xffffffff), FontWeight.w700,
                          "NotoSansKR", 20.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
