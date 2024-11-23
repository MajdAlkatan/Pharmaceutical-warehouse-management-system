// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({this.iconName, @required this.icon, super.key, this.controller,this.validator});
  TextEditingController? controller;
  String? iconName;
  Icon? icon;
      var validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       
      validator: validator,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      cursorColor: const Color(0xffAC82FE),
      controller:controller ,
      decoration: InputDecoration(
        fillColor: Colors.white,
        labelText: iconName,
        labelStyle: TextStyle(color: Color(0xffAC82FE)),
        label: icon,
      ),
    );
  }
}
