import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/colors.dart';

class TitleTextfield extends StatelessWidget {
  //final String label;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const TitleTextfield ({
    //required this.label,
    this.controller,
    this.onTap, // onTap 매개변수 추가
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      child: TextField(
        controller: controller,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: '일정제목',
          hintStyle: TextStyle(
            fontSize: 17.0,
            color: Colors.grey,
          ),
          counterText: '', // 기본 카운터 텍스트 제거
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: white_01),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: white_01),
          ),
        ),
        maxLength: 30,
      ),
    );
  }
}