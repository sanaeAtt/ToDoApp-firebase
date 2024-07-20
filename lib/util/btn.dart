// ignore_for_file: sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBtn extends StatelessWidget {
  final String btnName;
  VoidCallback onPressedBtn;
  Color color;
  MyBtn(
      {super.key,
      required this.btnName,
      required this.onPressedBtn,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressedBtn,
      child: Text(btnName),
      color: color,
    );
  }
}
