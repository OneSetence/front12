import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
import '../const/colors.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count;

  const TodayBanner({
    required this.selectedDate,
    required this.count,
    Key? key,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: white_01,
    );

    return Container(
      color: blue_01,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
              style: textStyle,
            ),
            Text(
              '$count개',
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}