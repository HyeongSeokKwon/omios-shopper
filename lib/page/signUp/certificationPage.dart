import 'package:flutter/material.dart';
import 'package:iamport_flutter/Iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

// /* 아임포트 휴대폰 본인인증 모듈을 불러옵니다. */
// import 'package:iamport_flutter/iamport_certification.dart';
// /* 아임포트 휴대폰 본인인증 데이터 모델을 불러옵니다. */
// import 'package:iamport_flutter/model/certification_data.dart';

class Certification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        title: new Text('아임포트 본인인증'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'iamport',
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData(
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        company: '아임포트', // 회사명 또는 URL
        carrier: 'KT', // 통신사
        name: '권형석', // 이름
        phone: '01066517392', // 전화번호
      ),
      /* [필수입력] 콜백 함수 */

      callback: (Map<String, String> result) {
        Navigator.pop(context);
      },
    );
  }
}
