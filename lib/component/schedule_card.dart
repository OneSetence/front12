import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../const/colors.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_share.dart';
import 'dart:io';




class ScheduleCard extends StatelessWidget {
  final int? start_year;
  final int? start_month;
  final int? start_day;
  final int? start_hour;
  final int? start_minutes;

  final int? end_year;
  final int? end_month;
  final int? end_day;
  final int? end_hour;
  final int? end_minutes;

  final String content;
  final String state;

  const ScheduleCard({
    this.start_year,
    this.start_month,
    this.start_day,
    this.start_hour,
    this.start_minutes,
    this.end_year,
    this.end_month,
    this.end_day,
    this.end_hour,
    this.end_minutes,
    required this.content,
    required this.state,
    Key? key,
  }) : super(key: key);

  factory ScheduleCard.fromJson(Map<String, dynamic> json) {
    // JSON에서 가져오는 데이터가 null일 경우 기본값 설정
    int? startYear = json['start'] != null ? json['start'][0] : null;
    int? startMonth = json['start'] != null ? json['start'][1] : null;
    int? startDay = json['start'] != null ? json['start'][2] : null;
    int? startHour = json['start'] != null ? json['start'][3] : null;
    int? startMinutes = json['start'] != null ? json['start'][4] : null;

    int? endYear = json['end'] != null ? json['end'][0] : null;
    int? endMonth = json['end'] != null ? json['end'][1] : null;
    int? endDay = json['end'] != null ? json['end'][2] : null;
    int? endHour = json['end'] != null ? json['end'][3] : null;
    int? endMinutes = json['end'] != null ? json['end'][4] : null;

    String state = json['status'] ?? 'Unknown';
    if (state == 'TODO') {
      state = '시작 전';
    } else if (state == 'DONE') {
      state = '완료됨';
    } else if (state == 'IN_PROGRESS') {
      state = '진행 중';
    }

    return ScheduleCard(
      start_year: startYear,
      start_month: startMonth,
      start_day: startDay,
      start_hour: startHour,
      start_minutes: startMinutes,
      end_year: endYear,
      end_month: endMonth,
      end_day: endDay,
      end_hour: endHour,
      end_minutes: endMinutes,
      content: json['title'] ?? '제목 없음',
      state: state,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: blue_01,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Time(
                    startTime: '$start_hour시 $start_minutes분  ',
                    endTime: '$end_hour시 $end_minutes분  ',
                  ),
                  _Content(
                    content: content,
                  ),
                  SizedBox(width: 16.0),
                  _Content(
                    content: state,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0), // Row들 사이에 공간을 추가
            IntrinsicHeight(
              child: Row(
                children: [
                  GestureDetector(
                    // 웹 채팅 부르기
                    onTap: () {
                      kakao_share();


                      //print('공유 아이콘 클릭됨');
                    },
                    child: Icon(
                      Icons.share,
                      color: blue_01,
                      size: 24.0, // 아이콘 크기 조정
                    ),
                  ),
                  //SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격 조정
                  //_AnotherInfo(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  final String startTime;
  final String endTime;

  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: blue_01,
      fontSize: 15.0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          startTime,
          style: textStyle,
        ),
        Text(
          endTime,
          style: textStyle.copyWith(
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final String content;

  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
      ),
    );
  }
}

class _AnotherInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('다른 정보'); // 예시 텍스트
  }
}

void kakao_share() async {
  bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

  if (isKakaoTalkSharingAvailable) {
    print('카카오톡으로 공유 가능');
  } else {
    print('카카오톡 미설치: 웹 공유 기능 사용 권장');
  }

  final FeedTemplate defaultFeed = FeedTemplate(
    content: Content(
      title: '한끝봇과 간편하게 예진 님과의 일정을 조율해보세요!',
      imageUrl: Uri.parse(
          'https://i.ibb.co/8X3v8n7/image.png'),
      link: Link(
          webUrl: Uri.parse('https://developers.kakao.com'),
          mobileWebUrl: Uri.parse('https://developers.kakao.com')),
    ),
    itemContent: ItemContent(
      //profileText: 'Kakao',
      //profileImageUrl: Uri.parse(
      //'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
      //titleImageUrl: Uri.parse(
      //'https://mud-kage.kakao.com/dn/Q2iNx/btqgeRgV54P/VLdBs9cvyn8BJXB3o7N8UK/kakaolink40_original.png'),
      titleImageText: '예진님으로부터 일정 변경 요청이 도착했어요',
      //titleImageCategory: 'cake',


    ),
    buttons: [
      Button(
        title: '누르면 이수윤 바보됨',
        link: Link(
          // 카카오 디벨로퍼 web 플랫폼 도메인과 일치해야 됨
          webUrl: Uri.parse('https://www.youtube.com'),
          mobileWebUrl: Uri.parse('https://www.youtube.com'),
        ),
      ),
    ],
  );

  // 카카오톡 실행 가능 여부 확인
  //bool isKakaoTalkSharingAvailable = await ShareClient.instance.isKakaoTalkSharingAvailable();

  if (isKakaoTalkSharingAvailable) {
    try {
      Uri uri =
      await ShareClient.instance.shareDefault(template: defaultFeed);
      await ShareClient.instance.launchKakaoTalk(uri);
      print('카카오톡 공유 완료');
    } catch (error) {
      print('카카오톡 공유 실패 $error');
    }
  } else {
    try {
      Uri shareUrl = await WebSharerClient.instance
          .makeDefaultUrl(template: defaultFeed);
      await launchBrowserTab(shareUrl, popupOpen: true);
    } catch (error) {
      print('카카오톡 공유 실패 $error');
    }
  }

}