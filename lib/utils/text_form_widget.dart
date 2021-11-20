// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class LeaveRequestFormWidget extends StatelessWidget {
  String hintText;
  int maxLine;
  TextEditingController controller;
  TextInputType? keyBoradType;

  // String initialValue;
  String? Function(String?)? validator;
  // void Function(String)? onChange;
  void Function(String?)? onSave;
  // Widget suffixIcon;
  // bool isSuffix;
  Widget? prefix;
  InputDecoration? decoration;
  // TextInputType textInputType;

  LeaveRequestFormWidget({
    this.keyBoradType,
    required this.hintText,
    required this.maxLine,
    required this.controller,
    // required this.initialValue,
    required this.validator,
    // required this.onChange,
    required this.onSave,
    // required this.suffixIcon,
    // required this.isSuffix,
    required this.prefix,
    required this.decoration,
    // required this.textInputType
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyBoradType,
      controller: controller,
      onSaved: onSave,
      validator: validator,
      decoration: decoration,
    );
  }
}
