
import '../const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';




class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;

  const CustomTextField ({
    required this.label,
    required this.isTime,
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
        Expanded(
          flex: isTime ? 0 : 1,
          child: TextFormField(
            cursorColor: Colors.grey,
            maxLines: isTime ? 1 : null,
            expands: !isTime,
            keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
            inputFormatters: isTime
              ? [
                FilteringTextInputFormatter.digitsOnly,
            ]
                : [],
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none, // 테두리 색상 없음
              ),
              filled: true,
              fillColor: textfield_bg_01,
              suffixText: isTime ? '시' : null,
            ),
          ),
        ),
      ],
    );
  }
}