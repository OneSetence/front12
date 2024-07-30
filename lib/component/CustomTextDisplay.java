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
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: textfield_bg_01,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              displayText,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
