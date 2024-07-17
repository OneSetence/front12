import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
import '../const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

const List<String> categroy_list = <String>['운동', '학교,', '한이음', '동아리'];

class CategroyDropdown extends StatefulWidget {
  const CategroyDropdown({super.key});

  @override
  State<CategroyDropdown> createState() => _CategroyDropdowneState();
}

class _CategroyDropdowneState extends State<CategroyDropdown> {
  String categroy = categroy_list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      //value: categroy,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        // Add more decoration..
      ),
      hint: const Text(
        '카테고리를 선택해주세요!',
        style: TextStyle(fontSize: 14),
      ),

      onChanged: (String? value){
        setState(() {
          categroy = value!;
        });
      },
      items: categroy_list.map<DropdownMenuItem<String>>((String value){
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