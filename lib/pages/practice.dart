import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body:Center(
        child: ElevatedButton(
          child: const Text('돌아가기'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}