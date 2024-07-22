import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        }
      ),
    );
  }
}