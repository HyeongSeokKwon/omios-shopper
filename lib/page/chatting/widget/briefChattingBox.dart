import 'package:cloth_collection/util/util.dart';
import 'package:flutter/material.dart';

class BriefChattingBox extends StatefulWidget {
  @override
  _BriefChattingBoxState createState() => _BriefChattingBoxState();
}

class _BriefChattingBoxState extends State<BriefChattingBox> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      child: Row(
        children: [
          SizedBox(width: width * 0.048),
          Container(
              width: width * 0.126,
              height: width * 0.126,
              child: Image.asset("assets/images/musinsa.png")),
          SizedBox(width: width * 0.034),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "무신사 스토어",
                style: textStyle(const Color(0xff404040), FontWeight.w500,
                    "NotoSansKR", 16.0),
              ),
              Text(
                "애플이 현대차에 협업을 제안했다는 뉴스가 나왔습니다.",
                style: textStyle(const Color(0xff797979), FontWeight.w400,
                    "NotoSansKR", 14.0),
                maxLines: 2,
              )
            ],
          )
        ],
      ),
    );
  }
}
