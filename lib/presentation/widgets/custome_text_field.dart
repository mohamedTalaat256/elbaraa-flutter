// ignore_for_file: unnecessary_question_mark

import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String text;
  final Color hintStyle;
  final Color fillColor;
  final Function(String?) onSave;
  final bool obscureText;
  final bool isDecorated;
  final TextEditingController controller;

  final validator;

  const CustomeTextField(
      {this.isDecorated = false,
      this.obscureText = false,
      this.keyboardType = TextInputType.name,
      this.text = '',
      this.hintStyle = Colors.grey,
      this.fillColor = Colors.grey,
      required this.validator,
      required this.onSave,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onSave,
      validator: validator,
      cursorColor: Theme.of(context).primaryColor,
      decoration: isDecorated == false
          ? InputDecoration(
              hintText: text,
              hintStyle: TextStyle(
                color: hintStyle,
              ),
              fillColor: fillColor)
          : InputDecoration(
              focusColor: Theme.of(context).primaryColor,
              border: InputBorder.none,
            ),
    );
  }
}
