// ignore_for_file: must_be_immutable

import 'package:app5/services/loginservice.dart';
import 'package:flutter/material.dart';

class MyTextButton extends StatefulWidget {
  MyTextButton({
    required this.text,
    super.key,
    required this.onpressed
  });
  String text;
  dynamic onpressed;

  @override
  State<MyTextButton> createState() => _MyTextButtonState();
}

class _MyTextButtonState extends State<MyTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(StadiumBorder()),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xffAC82FF),
        ),
      ),
      onPressed: widget.onpressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 23),
        child: Text(
          widget.text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
