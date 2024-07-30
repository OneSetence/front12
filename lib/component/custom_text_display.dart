import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomTextDisplay extends StatelessWidget {
  final String label;
  final String displayText;
  final VoidCallback? onTap;

  const CustomTextDisplay({
    required this.label,
    required this.displayText,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: blue_01,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.0),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50.0,
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: textfield_bg_01,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              displayText.isEmpty ? '날짜를 선택해주세요' : displayText,
              style: TextStyle(
                color: displayText.isEmpty ? Colors.grey : Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

