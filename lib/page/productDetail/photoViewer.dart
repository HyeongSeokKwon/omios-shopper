import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
  @override
  void initState() {
    super.initState();
    curIndex = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: widget.index);
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              allowImplicitScrolling: true,
              controller: _pageController,
              physics: ClampingScrollPhysics(),
              itemCount: widget.imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: CachedNetworkImageProvider(
                      "${widget.imageList[index]['url']}"),
                ));
              },
              onPageChanged: (value) {
                curIndex = value;

                setState(() {});
              },
            ),
            Positioned(
              top: 20 * Scale.height,
              right: 20 * Scale.height,
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
            Positioned(
              top: 20 * Scale.height,
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
          ],
        ),
      ),
    );
  }
}