// ignore_for_file: must_be_immutable

import 'package:blog_app/core/const.dart';
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  String text;
  IconData icon;
  TextEditingController controller;
  FormFieldValidator<String>? validator;

  CustomTextFieldWidget({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        width: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: textfieldcolor,
          border: Border.all(color: bordercolor),
        ),
        child: TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 100),
            label: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            prefixIcon: Icon(icon, color: Colors.black54),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
      ),
    );
  }
}
