import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../const/colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime;
  final TextEditingController? controller;
  final VoidCallback? onTap;

  const CustomTextField ({
    required this.label,
    required this.isTime,
    this.controller,
    this.onTap, // onTap 매개변수 추가
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
            controller: controller,
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
              //suffixText: isTime ? '시' : null,
            ),
            onTap: onTap, // onTap 전달
          ),
        ),
      ],
    );
  }
}

