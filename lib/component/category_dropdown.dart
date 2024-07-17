import 'package:flutter/material.dart';
import '../component/custom_text_field.dart';
import '../const/colors.dart';

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
    return DropdownButton<String>(
      value: categroy,
      icon : const Icon(Icons.arrow_downward),
      elevation: 10,
      style: const TextStyle(color: Colors.deepPurple),
      //underline: Container(
      //height: 2,
      //color: Colors.deepPurpleAccent,

      //),
      onChanged: (String? value){
        setState(() {
          categroy = value!;
        });
      },
      items: categroy_list.map<DropdownMenuItem<String>>((String value){
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}