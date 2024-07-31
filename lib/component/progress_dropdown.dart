import 'package:flutter/material.dart';
import '../const/colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

const List<String> progress_list = <String>['시작전', '진행중', '완료'];

class ProgressDropdown extends StatefulWidget {
  final ValueChanged<String?>? onChanged; // 추가된 부분

  const ProgressDropdown({Key? key, this.onChanged}) : super(key: key);

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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: DropdownButtonFormField2<String>(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          fillColor: textfield_bg_01,
          filled: true,
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
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
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

