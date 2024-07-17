import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
import '../const/colors.dart';


const List<String> progress_list = <String>['시작전', '진행중,', '완료'];

class ProgressDropdown extends StatefulWidget {
  const ProgressDropdown({super.key});

  @override
  State<ProgressDropdown> createState() => _ProgressDropdownState();
}

class _ProgressDropdownState extends State<ProgressDropdown> {
  String progress = progress_list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: progress,
      icon : const Icon(Icons.arrow_downward),
      elevation: 10,
      style: const TextStyle(color: Colors.deepPurple),
      //underline: Container(
      //height: 2,
      //color: Colors.deepPurpleAccent,

      //),
      onChanged: (String? value){
        setState(() {
          progress = value!;
        });
      },
      items: progress_list.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}