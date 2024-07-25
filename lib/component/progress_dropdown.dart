import 'package:flutter/material.dart';
import '../const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

const List<String> progress_list = <String>['시작전', '진행중', '완료'];

class ProgressDropdown extends StatefulWidget {
  const ProgressDropdown({super.key});

  @override
  State<ProgressDropdown> createState() => _ProgressDropdownState();
}

class _ProgressDropdownState extends State<ProgressDropdown> {
  String progress = progress_list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textfield_bg_01,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical:0 ),
      child: DropdownButtonFormField2<String>(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none, // 테두리 없음
          ),
          fillColor: textfield_bg_01, // 배경색 설정
          filled: true, // fillColor 사용하려면 필요
        ),
        hint: const Text(
          '진행상태를 선택해주세요!',
          style: TextStyle(fontSize: 14),
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
        ),
        onChanged: (String? value) {
          setState(() {
            progress = value!;
          });
        },
        items: progress_list.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
