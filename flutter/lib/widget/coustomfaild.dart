import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {this.hintText,
      this.inputType,
      this.onChanged,
      this.obscureText = false,
      this.controller,
      this.validator, 
      });
  Function(String)? onChanged;
  String? hintText;
  TextInputType? inputType;
  bool? obscureText;
  TextEditingController? controller;
  var validator;
GlobalKey formstate =GlobalKey();

  

  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      style: const TextStyle(fontSize: 16, color: Colors.white),
      
      validator: validator,
      controller: controller,
      obscureText: obscureText!,
      onChanged: onChanged,
      keyboardType: inputType,
      decoration: InputDecoration(
          focusColor: Colors.white,
          label: Text("$hintText"),
          labelStyle: TextStyle(fontSize: 18, color: Colors.white70),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white30),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 100,
              color: Colors.white60,
            ),
          )),
    );
  }
}
