import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
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
    return DropdownButtonFormField2<String>(
      //value: progress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: const Text(
        '진행상태를 선택해주세요!',
        style: TextStyle(fontSize: 14),
      ),

      onChanged: (String? value){
        setState(() {
          progress = value!;
        });
      },
      items: progress_list.map<DropdownMenuItem<String>>((String value){
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
    );
  }
}