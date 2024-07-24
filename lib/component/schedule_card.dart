import 'package:flutter/material.dart';
import '../const/colors.dart';

class ScheduleCard extends StatelessWidget {
  final int start_year;
  final int start_month;
  final int start_day;
  final int start_hour;
  final int start_minutes;

  final int end_year;
  final int end_month;
  final int end_day;
  final int end_hour;
  final int end_minutes;

  final String content;
  final String state;


  const ScheduleCard({
    required this.start_year,
    required this.start_month,
    required this.start_day,
    required this.start_hour,
    required this.start_minutes,
    required this.end_year,
    required this.end_month,
    required this.end_day,
    required this.end_hour,
    required this.end_minutes,
    required this.content,
    required this.state,
    Key? key,
  }) : super(key: key);

  factory ScheduleCard.fromJson(Map<String, dynamic> json) {

    String state = json['status'];
    if (state == 'TODO') {
      state = '시작';
    }
    return ScheduleCard(
      start_year: json['start'][0],
      start_month: json['start'][1],
      start_day: json['start'][2],
      start_hour: json['start'][3],
      start_minutes: json['start'][4],
      end_year: json['end'][0],
      end_month: json['end'][1],
      end_day: json['end'][2],
      end_hour: json['end'][3],
      end_minutes: json['end'][4],
      content: json['title'],
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

      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Time(
                startTime: start_hour.toString() + '시 ' + start_minutes.toString() + '분  ',
                endTime: end_hour.toString() + '시 ' + end_minutes.toString() + '분  ',
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
  }) : super (key: key);

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
          '${startTime.toString()}',
          style: textStyle,
        ),
        Text(
          '${endTime.toString()}',
          style: textStyle.copyWith(
          fontSize: 15.0,
          ),
        ),
      ],
    );
  }
}

// 콘텐츠 담을 거
class _Content extends StatelessWidget {
  final String content;


   const _Content({
    required this.content,
    Key? key,
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        content,
      ),
    );
  }
}